package com.h2o.h2oServer.domain.trim;

import com.h2o.h2oServer.domain.trim.dto.InternalColorDto;
import com.h2o.h2oServer.domain.trim.entity.InternalColorEntity;

import java.util.List;

public class InternalColorFixture {
    public static List<InternalColorEntity> generateInernalColorEntityList() {
        return List.of(
                InternalColorEntity.builder()
                        .id(1L)
                        .choiceRatio(0.3f)
                        .price(2000)
                        .fabricImage("fabric_image_url_1")
                        .internalImage("internal_image_url_1")
                        .name("Red")
                        .build(),
                InternalColorEntity.builder()
                        .id(2L)
                        .choiceRatio(0.2f)
                        .price(1500)
                        .fabricImage("fabric_image_url_2")
                        .internalImage("internal_image_url_2")
                        .name("Blue")
                        .build()
        );
    }

    public static List<InternalColorDto> generateInternalColorDtos() {
        List<InternalColorEntity> internalColorEntities = generateInernalColorEntityList();
        return List.of(
                InternalColorDto.of(internalColorEntities.get(0)),
                InternalColorDto.of(internalColorEntities.get(1))
        );
    }
}
