package com.h2o.h2oServer.domain.option;

import com.h2o.h2oServer.domain.option.entity.OptionDetailsEntity;
import com.h2o.h2oServer.domain.option.entity.OptionEntity;
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
}
