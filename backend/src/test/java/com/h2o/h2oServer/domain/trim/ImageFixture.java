package com.h2o.h2oServer.domain.trim;

import com.h2o.h2oServer.domain.trim.entity.ImageEntity;

import java.util.List;

public class ImageFixture {
    public static List<ImageEntity> generateImageEntityList() {
        return List.of(
                ImageEntity.builder()
                        .image("url1")
                        .id(1L)
                        .build(),
                ImageEntity.builder()
                        .image("url2")
                        .id(2L)
                        .build()
        );
    }
}
