package com.h2o.h2oServer.domain.trim;

import com.h2o.h2oServer.domain.trim.dto.ExternalColorDto;
import com.h2o.h2oServer.domain.trim.entity.ExternalColorEntity;

import java.util.List;

public class ExternalColorFixture {
    public static List<ExternalColorEntity> generateExternalColorEntityList() {
        return List.of(
                ExternalColorEntity.builder()
                        .id(1L)
                        .name("Red")
                        .colorCode("#FF0000")
                        .choiceRatio(0.5F)
                        .price(100)
                        .build(),
                ExternalColorEntity.builder()
                        .id(2L)
                        .name("Black")
                        .colorCode("#FF0001")
                        .choiceRatio(0.2F)
                        .price(240)
                        .build());
    }

    public static ExternalColorEntity generateExternalColorEntity() {
        return ExternalColorEntity.builder()
                .id(1L)
                .name("Red")
                .colorCode("#FF0000")
                .choiceRatio(0.5F)
                .price(100)
                .build();
    }

    public static List<ExternalColorDto> generateExternalColorDtos() {
        List<ExternalColorEntity> externalColorEntities = generateExternalColorEntityList();
        return List.of(
                ExternalColorDto.of(externalColorEntities.get(0), ImageFixture.generateImageEntityList()),
                ExternalColorDto.of(externalColorEntities.get(1), ImageFixture.generateImageEntityList())
        );
    }
}
