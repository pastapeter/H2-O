package com.h2o.h2oServer.domain.trim;

import com.h2o.h2oServer.domain.trim.entity.TrimEntity;

import java.util.List;

public class TrimFixture {
    public static List<TrimEntity> generateTrimEntityList() {
        return List.of(
                TrimEntity.builder()
                        .id(1L)
                        .name("Trim A")
                        .description("Description of Trim A")
                        .price(50000)
                        .carId(1L)
                        .build(),
                TrimEntity.builder()
                        .id(2L)
                        .name("Trim B")
                        .description("Description of Trim b")
                        .price(70000)
                        .carId(1L)
                        .build()
        );
    }

    public static TrimEntity generateTrimEntity(long carId) {
        return TrimEntity.builder()
                .id(1L)
                .name("Trim A")
                .description("Description of Trim A")
                .price(50000)
                .carId(carId)
                .build();
    }

    public static TrimEntity generateTrimEntity() {
        return TrimEntity.builder()
                .id(1L)
                .name("Trim A")
                .description("Description of Trim A")
                .price(50000)
                .carId(1L)
                .build();
    }
}
