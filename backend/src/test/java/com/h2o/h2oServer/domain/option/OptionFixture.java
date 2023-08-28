package com.h2o.h2oServer.domain.option;

import com.h2o.h2oServer.domain.option.dto.OptionDto;
import com.h2o.h2oServer.domain.option.dto.TrimExtraOptionDto;
import com.h2o.h2oServer.domain.option.entity.OptionDetailsEntity;
import com.h2o.h2oServer.domain.option.entity.OptionEntity;
import com.h2o.h2oServer.domain.option.entity.TrimDefaultOptionEntity;
import com.h2o.h2oServer.domain.option.entity.TrimExtraOptionEntity;
import com.h2o.h2oServer.domain.option.entity.enums.OptionCategory;
import com.h2o.h2oServer.domain.trim.entity.OptionStatisticsEntity;

import java.util.List;

public class OptionFixture {
    public static List<OptionStatisticsEntity> generateOptionStatisticsList() {
        return List.of(
                OptionStatisticsEntity.builder()
                        .id(1L)
                        .name("Option A")
                        .useCount(0.75F)
                        .build(),
                OptionStatisticsEntity.builder()
                        .id(2L)
                        .name("Option B")
                        .useCount(0.5F)
                        .build()
        );
    }

    public static OptionDetailsEntity generateOptionDetailsEntity() {
        return OptionDetailsEntity.builder()
                .name("Option 1")
                .image("image_url_1")
                .description("Description for Option 1")
                .choiceRatio(0.3f)
                .useCount(12.5f)
                .category(OptionCategory.POWERTRAIN_PERFORMANCE)
                .price(500)
                .optionType("default")
                .build();
    }

    public static OptionEntity generateOptionEntity() {
        return OptionEntity.builder()
                .name("Option 1")
                .image("image_url_1")
                .description("Description for Option 1")
                .useCount(12.5f)
                .category(OptionCategory.POWERTRAIN_PERFORMANCE)
                .build();
    }

    public static TrimExtraOptionEntity generateExtraOptionEntity() {
        return TrimExtraOptionEntity.builder()
                .id(1L)
                .name("Option 1")
                .image("image_url_1")
                .category(OptionCategory.ACCESSORY)
                .choiceRatio(0.8f)
                .price(10000)
                .build();
    }

    public static TrimDefaultOptionEntity generateDefaultOptionEntity() {
        return TrimDefaultOptionEntity.builder()
                .id(1L)
                .name("Option 1")
                .image("image_url_1")
                .category(OptionCategory.ACCESSORY)
                .choiceRatio(0.8f)
                .useCount(0.1f)
                .build();
    }

    public static List<OptionDto> generateOptionDtoList() {
        OptionEntity optionEntity = generateOptionEntity();
        return List.of(
                OptionDto.of(optionEntity, HashTagFixture.generateHashTagEntities()),
                OptionDto.of(optionEntity, HashTagFixture.generateHashTagEntities())
        );
    }

    public static List<TrimExtraOptionEntity> generateExtraOptionEntityList() {
        TrimExtraOptionEntity trimExtraOptionEntity = generateExtraOptionEntity();
        return List.of(trimExtraOptionEntity, trimExtraOptionEntity);
    }

    public static List<TrimDefaultOptionEntity> generateDefaultOptionEntityList() {
        TrimDefaultOptionEntity trimDefaultOptionEntity = generateDefaultOptionEntity();
        return List.of(trimDefaultOptionEntity, trimDefaultOptionEntity);
    }
}
