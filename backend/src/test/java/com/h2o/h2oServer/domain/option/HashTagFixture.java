package com.h2o.h2oServer.domain.option;

import com.h2o.h2oServer.domain.option.entity.HashTagEntity;
import com.h2o.h2oServer.domain.option.entity.enums.HashTag;

import java.util.List;
import java.util.stream.Collectors;

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

    public static List<HashTagEntity> generateHashTagEntities(List<HashTag> hashTags) {
        return hashTags.stream()
                .map(hashTag -> HashTagEntity.builder().name(hashTag).build())
                .collect(Collectors.toList());
    }
}
