package com.h2o.h2oServer.domain.trim.application;

import com.h2o.h2oServer.domain.car.mapper.CarMapper;
import com.h2o.h2oServer.domain.model_type.application.ModelTypeService;
import com.h2o.h2oServer.domain.trim.Exception.NoSuchTrimException;
import com.h2o.h2oServer.domain.trim.dto.DefaultTrimCompositionDto;
import com.h2o.h2oServer.domain.trim.dto.InternalColorDto;
import com.h2o.h2oServer.domain.trim.dto.ExternalColorDto;
import com.h2o.h2oServer.domain.trim.dto.PriceRangeDto;
import com.h2o.h2oServer.domain.trim.dto.TrimDto;
import com.h2o.h2oServer.domain.trim.dto.*;
import com.h2o.h2oServer.domain.trim.entity.ExternalColorEntity;
import com.h2o.h2oServer.domain.trim.entity.ImageEntity;
import com.h2o.h2oServer.domain.trim.entity.InternalColorEntity;
import com.h2o.h2oServer.domain.trim.entity.OptionStatisticsEntity;
import com.h2o.h2oServer.domain.trim.entity.TrimEntity;
import com.h2o.h2oServer.domain.trim.mapper.ExternalColorMapper;
import com.h2o.h2oServer.domain.trim.mapper.TrimMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@Service
@RequiredArgsConstructor
public class TrimService {
    public static final int DISTRIBUTION_SEGMENT_COUNT = 30;
    private final TrimMapper trimMapper;
    private final ExternalColorMapper externalColorMapper;
    private final CarMapper carMapper;
    private final ModelTypeService modelTypeService;

    public List<TrimDto> findTrimInformation(Long carId) {
        List<TrimEntity> trimEntities = trimMapper.findByCarId(carId);

        validateExistence(trimEntities);

        return trimEntities.stream()
                .map(this::manipulateTrimEntity)
                .collect(Collectors.toList());
    }

    public List<ExternalColorDto> findExternalColorInformation(Long trimId) {
        List<ExternalColorEntity> externalColorEntities = trimMapper.findExternalColor(trimId);

        validateExistence(externalColorEntities);

        return externalColorEntities.stream()
                .map(this::manipulateExternalColorEntity)
                .collect(Collectors.toList());
    }

    private TrimDto manipulateTrimEntity(TrimEntity trimEntity) {
        Long trimId = trimEntity.getId();
        List<OptionStatisticsEntity> optionStatisticsEntities = trimMapper.findOptionStatistics(trimId);
        List<ImageEntity> imageEntities = trimMapper.findImages(trimId);

        return TrimDto.of(trimEntity, imageEntities, optionStatisticsEntities);
    }

    private ExternalColorDto manipulateExternalColorEntity(ExternalColorEntity externalColorEntity) {
        Long externalColorEntityId = externalColorEntity.getId();
        List<ImageEntity> imageEntities = externalColorMapper.findImages(externalColorEntityId);

        return ExternalColorDto.of(externalColorEntity, imageEntities);
    }

    public List<InternalColorDto> findInternalColorInformation(Long trimId) {
        List<InternalColorEntity> internalColorEntities = trimMapper.findInternalColor(trimId);

        validateExistence(internalColorEntities);

        return internalColorEntities.stream()
                .map(InternalColorDto::of)
                .collect(Collectors.toList());
    }

    public PriceRangeDto findPriceRange(Long trimId) {
        TrimEntity trimEntity = trimMapper.findById(trimId);

        validateExistence(trimEntity);

        Long carId = trimEntity.getCarId();
        int trimPrice = trimEntity.getPrice();
        int componentPrice = trimMapper.findMaximumComponentPrice(trimId);

        Integer minimumModelTypePrice = carMapper.findMinimumModelTypePrice(carId);
        Integer maximumModelTypePrice = carMapper.findMaximumModelTypePrice(carId);

        return PriceRangeDto.of(trimPrice + maximumModelTypePrice + componentPrice,
                trimPrice + minimumModelTypePrice);
    }

    public DefaultTrimCompositionDto findDefaultComposition(Long trimId) {
        TrimEntity trimEntity = trimMapper.findById(trimId);

        validateExistence(trimEntity);
        Long carId = trimEntity.getCarId();
        DefaultTrimCompositionDto defaultTrimCompositionDto = modelTypeService.findDefaultModelType(carId);

        ExternalColorEntity defaultExternalColor = trimMapper.findDefaultExternalColor(trimId);
        InternalColorEntity defaultInternalColor = trimMapper.findDefaultInternalColor(trimId);
        List<ImageEntity> imageEntities = externalColorMapper.findImages(defaultExternalColor.getId());

        defaultTrimCompositionDto.setInternalColor(InternalColorDto.of(defaultInternalColor));
        defaultTrimCompositionDto.setExternalColor(ExternalColorDto.of(defaultExternalColor, imageEntities));

        return defaultTrimCompositionDto;
    }

    private static void validateExistence(TrimEntity trimEntity) {
        if (trimEntity == null) {
            throw new NoSuchTrimException();
        }
    }

    private static void validateExistence(List entities) {
        if (entities == null || entities.isEmpty()) {
            throw new NoSuchTrimException();
        }
    }


    public PriceDistributionDto findAndScalePriceDistribution(Long trimId) {
        PriceRangeDto priceRangeDto = findPriceRange(trimId);
        Integer minPrice = priceRangeDto.getMinPrice();

        int unit = (priceRangeDto.getMaxPrice() - minPrice) / DISTRIBUTION_SEGMENT_COUNT;

        List<Integer> quantityPerUnit = IntStream.range(0, DISTRIBUTION_SEGMENT_COUNT)
                .mapToObj(index -> trimMapper.findQuantityBetween(trimId, minPrice + unit * index, minPrice + unit * (index + 1)))
                .collect(Collectors.toList());

        return PriceDistributionDto.of(unit, quantityPerUnit);
    }
}
