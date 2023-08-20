package com.h2o.h2oServer.domain.option;

import com.h2o.h2oServer.domain.option.entity.HashTagEntity;
import com.h2o.h2oServer.domain.option.entity.enums.HashTag;

import java.util.List;

public class HashTagFixture {

    public static List<HashTagEntity> generateHashTagEntities() {
        return List.of(
                HashTagEntity.builder()
                        .name(HashTag.CAMPING)
                        .build(),
                HashTagEntity.builder()
                        .name(HashTag.LEISURE)
                        .build(),
                HashTagEntity.builder()
                        .name(HashTag.SPORTS)
                        .build()
        );
    }
}
