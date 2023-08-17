package com.h2o.h2oServer.domain.quotation.application;

import com.h2o.h2oServer.domain.car.exception.NoSuchCarException;
import com.h2o.h2oServer.domain.car.mapper.CarMapper;
import com.h2o.h2oServer.domain.model_type.dto.ModelTypeIdDto;
import com.h2o.h2oServer.domain.model_type.exception.NoSuchBodyTypeException;
import com.h2o.h2oServer.domain.model_type.exception.NoSuchDriveTrainException;
import com.h2o.h2oServer.domain.model_type.exception.NoSuchPowertrainException;
import com.h2o.h2oServer.domain.model_type.mapper.BodytypeMapper;
import com.h2o.h2oServer.domain.model_type.mapper.DrivetrainMapper;
import com.h2o.h2oServer.domain.model_type.mapper.PowertrainMapper;
import com.h2o.h2oServer.domain.option.exception.NoSuchOptionException;
import com.h2o.h2oServer.domain.option.mapper.OptionMapper;
import com.h2o.h2oServer.domain.optionPackage.exception.NoSuchPackageException;
import com.h2o.h2oServer.domain.optionPackage.mapper.PackageMapper;
import com.h2o.h2oServer.domain.quotation.dto.QuotationRequestDto;
import com.h2o.h2oServer.domain.quotation.dto.QuotationResponseDto;
import com.h2o.h2oServer.domain.quotation.dto.QuotationDto;
import com.h2o.h2oServer.domain.quotation.entity.OptionQuotationEntity;
import com.h2o.h2oServer.domain.quotation.entity.PackageQuotationEntity;
import com.h2o.h2oServer.domain.quotation.mapper.QuotationMapper;
import com.h2o.h2oServer.domain.trim.Exception.NoSuchTrimException;
import com.h2o.h2oServer.domain.trim.mapper.TrimMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class QuotationService {

    private final QuotationMapper quotationMapper;
    private final CarMapper carMapper;
    private final TrimMapper trimMapper;
    private final PowertrainMapper powertrainMapper;
    private final BodytypeMapper bodytypeMapper;
    private final DrivetrainMapper drivetrainMapper;
    private final OptionMapper optionMapper;
    private final PackageMapper packageMapper;

    @Transactional
    public QuotationResponseDto saveQuotation(QuotationRequestDto quotationRequestDto) {
        Long quotationId = insertIntoQuotation(quotationRequestDto);

        validateQuotationRequest(quotationRequestDto);

        insertIntoOptionQuotation(quotationRequestDto.getOptionIds(), quotationId);
        insertIntoPackageQuotation(quotationRequestDto.getPackageIds(), quotationId);

        return QuotationResponseDto.of(quotationId);
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
        if (!drivetrainMapper.checkIfDrivetrainExists(modelTypeIdDto.getDrivetrainId())){
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

    private Long insertIntoQuotation(QuotationRequestDto quotationRequestDto) {
        QuotationDto quotationDto = QuotationDto.of(quotationRequestDto);
        quotationMapper.saveQuotation(quotationDto);

        return quotationDto.getId();
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
}
