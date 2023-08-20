package com.h2o.h2oServer.domain.quotation.application;

import com.h2o.h2oServer.domain.car.exception.NoSuchCarException;
import com.h2o.h2oServer.domain.car.mapper.CarMapper;
import com.h2o.h2oServer.domain.model_type.dto.ModelTypeIdDto;
import com.h2o.h2oServer.domain.model_type.dto.ModelTypeNameDto;
import com.h2o.h2oServer.domain.model_type.exception.NoSuchBodyTypeException;
import com.h2o.h2oServer.domain.model_type.exception.NoSuchDriveTrainException;
import com.h2o.h2oServer.domain.model_type.exception.NoSuchPowertrainException;
import com.h2o.h2oServer.domain.model_type.mapper.BodytypeMapper;
import com.h2o.h2oServer.domain.model_type.mapper.DrivetrainMapper;
import com.h2o.h2oServer.domain.model_type.mapper.PowertrainMapper;
import com.h2o.h2oServer.domain.option.dto.OptionSummaryDto;
import com.h2o.h2oServer.domain.option.entity.HashTagEntity;
import com.h2o.h2oServer.domain.option.entity.OptionDetailsEntity;
import com.h2o.h2oServer.domain.option.entity.enums.HashTag;
import com.h2o.h2oServer.domain.option.exception.NoSuchOptionException;
import com.h2o.h2oServer.domain.option.mapper.OptionMapper;
import com.h2o.h2oServer.domain.optionPackage.exception.NoSuchPackageException;
import com.h2o.h2oServer.domain.optionPackage.mapper.PackageMapper;
import com.h2o.h2oServer.domain.quotation.dto.QuotationRequestDto;
import com.h2o.h2oServer.domain.quotation.dto.QuotationResponseDto;
import com.h2o.h2oServer.domain.quotation.dto.QuotationDto;
import com.h2o.h2oServer.domain.quotation.dto.SimilarQuotationDto;
import com.h2o.h2oServer.domain.quotation.entity.OptionQuotationEntity;
import com.h2o.h2oServer.domain.quotation.entity.PackageQuotationEntity;
import com.h2o.h2oServer.domain.quotation.entity.ReleaseEntity;
import com.h2o.h2oServer.domain.quotation.mapper.QuotationMapper;
import com.h2o.h2oServer.domain.trim.Exception.NoSuchTrimException;
import com.h2o.h2oServer.domain.trim.mapper.ExternalColorMapper;
import com.h2o.h2oServer.domain.trim.mapper.TrimMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

import static com.h2o.h2oServer.global.util.StringParser.*;

@Service
@RequiredArgsConstructor
public class QuotationService {
    public static final double SIMILARITY_LOWER_BOUND = 0.2;
    public static final double SIMILARITY_UPPER_BOUND = 0.9;
    public static final int SIDE_IMAGE_INDEX = 12;

    private final QuotationMapper quotationMapper;
    private final CarMapper carMapper;
    private final TrimMapper trimMapper;
    private final PowertrainMapper powertrainMapper;
    private final BodytypeMapper bodytypeMapper;
    private final DrivetrainMapper drivetrainMapper;
    private final OptionMapper optionMapper;
    private final PackageMapper packageMapper;
    private final ExternalColorMapper externalColorMapper;

    public List<SimilarQuotationDto> findSimilarQuotations(QuotationRequestDto quotationRequestDto) {

        //1. 요청된 견적의 해시태그 벡터 초기화
        Map<HashTag, Integer> requestHashTagCount = new HashMap<>();

        collectHashTagsOfOptions(quotationRequestDto.getOptionIds(), requestHashTagCount);

        collectHashTagsOfPackages(quotationRequestDto.getPackageIds(), requestHashTagCount);

        //2. 출고 견적 데이터 가져오기
        List<ReleaseEntity> releaseEntities = quotationMapper.findReleaseQuotationWithVolume(quotationRequestDto.getTrimId());

        PriorityQueue<Map.Entry<ReleaseEntity, Double>> similarityQueue = new PriorityQueue<>(
                (entry1, entry2) -> (-1) * Double.compare(entry1.getValue(), entry2.getValue())
        );

        //3. 출고 견적 데이터와의 코사인 유사도 정리
        for (ReleaseEntity releaseEntity : releaseEntities) {
            List<Long> optionIds = parseToLongList(releaseEntity.getOptionCombination());
            List<Long> packageIds = parseToLongList(releaseEntity.getPackageCombination());

            Map<HashTag, Integer> hashTagCount = new HashMap<>();

            //3-1. 옵션에 포함된 해시태그 정보 가져오기
            collectHashTagsOfOptions(optionIds, hashTagCount);

            //3-2. 패키지에 포함된 해시태그 정보 가져오기
            collectHashTagsOfPackages(packageIds, hashTagCount);

            //유사도 계산 후 queue에 추가
            double similarity = CosineSimilarityCalculator.calculateCosineSimilarity(requestHashTagCount, hashTagCount);

            if (similarity < SIMILARITY_LOWER_BOUND || similarity > SIMILARITY_UPPER_BOUND) {
                continue;
            }

            similarityQueue.add(Map.entry(releaseEntity, similarity));
        }

        List<SimilarQuotationDto> similarQuotationDtos = new ArrayList<>();

        //4. entity to DTO 변환
        for (int index = 0; index < 4; index++) {
            ReleaseEntity releaseEntity = similarityQueue.poll().getKey();

            String powertrainName = powertrainMapper.findById(releaseEntity.getPowertrainId()).getName();
            String bodytypeName = bodytypeMapper.findById(releaseEntity.getBodytypeId()).getName();
            String drivetrainName = drivetrainMapper.findById(releaseEntity.getDrivetrainId()).getName();
            String image = externalColorMapper.findImages(releaseEntity.getExternalColorId()).get(SIDE_IMAGE_INDEX).getImage();
            int price = releaseEntity.getPrice();

            List<OptionSummaryDto> optionSummaryDtos = extractOptionSummary(quotationRequestDto, releaseEntity);

            similarQuotationDtos.add(SimilarQuotationDto.of(
                    ModelTypeNameDto.builder()
                            .bodytypeName(bodytypeName)
                            .drivetrainName(drivetrainName)
                            .powertrainName(powertrainName)
                            .build(),
                    image,
                    price,
                    optionSummaryDtos
            ));
        }

        return similarQuotationDtos;
    }

    private List<OptionSummaryDto> extractOptionSummary(QuotationRequestDto quotationRequestDto,
                                                        ReleaseEntity releaseEntity) {
        List<Long> optionIds = parseToLongList(releaseEntity.getOptionCombination());

        List<OptionSummaryDto> optionSummaryDtos = new ArrayList<>();

        for (Long optionId : optionIds) {
            if (quotationRequestDto.getOptionIds().contains(optionId)) {
                continue;
            }
            OptionDetailsEntity optionDetailsEntity = optionMapper.findOptionDetails(optionId, releaseEntity.getTrimId());
            optionSummaryDtos.add(OptionSummaryDto.of(optionId, optionDetailsEntity));

            if (optionSummaryDtos.size() > 1) {
                break;
            }
        }
        return optionSummaryDtos;
    }

    private void collectHashTagsOfPackages(List<Long> packageIds, Map<HashTag, Integer> hashTagCount) {
        packageIds.forEach((packageId) -> {
            List<HashTagEntity> hashTagEntities = packageMapper.findHashTag(packageId);

            for (HashTagEntity hashTagEntity : hashTagEntities) {
                HashTag hashTag = hashTagEntity.getName();
                hashTagCount.put(hashTag, hashTagCount.getOrDefault(hashTag, 0) + 1);
            }
        });
    }

    private void collectHashTagsOfOptions(List<Long> optionIds, Map<HashTag, Integer> hashTagCount) {
        optionIds.forEach((optionId) -> {
            List<HashTagEntity> hashTagEntities = optionMapper.findHashTag(optionId);

            for (HashTagEntity hashTagEntity : hashTagEntities) {
                HashTag hashTag = hashTagEntity.getName();
                hashTagCount.put(hashTag, hashTagCount.getOrDefault(hashTag, 0) + 1);
            }
        });
    }

    @Transactional
    public QuotationResponseDto saveQuotation(QuotationRequestDto quotationRequestDto) {
        Long quotationId = insertIntoQuotation(quotationRequestDto);

        validateQuotationRequest(quotationRequestDto);

        insertIntoOptionQuotation(quotationRequestDto.getOptionIds(), quotationId);
        insertIntoPackageQuotation(quotationRequestDto.getPackageIds(), quotationId);

        return QuotationResponseDto.of(quotationId);
    }

    private void insertIntoOptionQuotation(List<Long> optionIds, Long quotationId) {
        OptionQuotationEntity optionQuotationEntity = OptionQuotationEntity.builder()
                .quotationId(quotationId)
                .optionIds(optionIds)
                .build();

        quotationMapper.saveOptionQuotation(optionQuotationEntity);
    }

    private void insertIntoPackageQuotation(List<Long> packageIds, Long quotationId) {
        PackageQuotationEntity packageQuotationEntity = PackageQuotationEntity.builder()
                .quotationId(quotationId)
                .packageIds(packageIds)
                .build();

        quotationMapper.savePackageQuotation(packageQuotationEntity);
    }

    private Long insertIntoQuotation(QuotationRequestDto quotationRequestDto) {
        QuotationDto quotationDto = QuotationDto.of(quotationRequestDto);
        quotationMapper.saveQuotation(quotationDto);

        return quotationDto.getId();
    }

    private void validateQuotationRequest(QuotationRequestDto quotationRequestDto) {
        validateCarExistence(quotationRequestDto);
        validateTrimExistence(quotationRequestDto);
        validateModelTypeExistence(quotationRequestDto);
        validateOptionExistence(quotationRequestDto);
        validatePackageExistence(quotationRequestDto);
    }

    private void validateModelTypeExistence(QuotationRequestDto quotationRequestDto) {
        ModelTypeIdDto modelTypeIdDto = quotationRequestDto.getModelTypeIds();
        if (!powertrainMapper.checkIfPowertrainExists(modelTypeIdDto.getPowertrainId())) {
            throw new NoSuchPowertrainException();
        }
        if (!bodytypeMapper.checkIfBodytypeExists(modelTypeIdDto.getBodytypeId())) {
            throw new NoSuchBodyTypeException();
        }
        if (!drivetrainMapper.checkIfDrivetrainExists(modelTypeIdDto.getDrivetrainId())) {
            throw new NoSuchDriveTrainException();
        }
    }

    private void validateTrimExistence(QuotationRequestDto quotationRequestDto) {
        if (!trimMapper.checkIfTrimExists(quotationRequestDto.getTrimId())) {
            throw new NoSuchTrimException();
        }
    }

    private void validateCarExistence(QuotationRequestDto quotationRequestDto) {
        if (!carMapper.checkIfCarExists(quotationRequestDto.getCarId())) {
            throw new NoSuchCarException();
        }
    }

    private void validatePackageExistence(QuotationRequestDto quotationRequestDto) {
        quotationRequestDto.getPackageIds().stream()
                .filter(id -> !packageMapper.checkIfPackageExists(id))
                .findFirst()
                .ifPresent(id -> {
                    throw new NoSuchPackageException();
                });
    }
    private void validateOptionExistence(QuotationRequestDto quotationRequestDto) {
        quotationRequestDto.getOptionIds().stream()
                .filter(id -> !optionMapper.checkIfOptionExists(id))
                .findFirst()
                .ifPresent(id -> {
                    throw new NoSuchOptionException();
                });
    }

}
