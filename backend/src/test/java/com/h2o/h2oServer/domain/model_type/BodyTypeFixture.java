package com.h2o.h2oServer.domain.model_type;

import com.h2o.h2oServer.domain.model_type.Entity.BodytypeEntity;
import com.h2o.h2oServer.domain.model_type.Entity.CarBodytypeEntity;

import java.util.List;

public class BodyTypeFixture {

    public static BodytypeEntity generateBodytypeEntity() {
        return BodytypeEntity.builder()
                .id(1L)
                .name("name1")
                .description("description1")
                .image("img_url1")
                .build();
    }

    public static CarBodytypeEntity generateCarBodyTypeEntity() {
        return CarBodytypeEntity.builder()
                .carId(1L)
                .name("name1")
                .description("description1")
                .image("img_url1")
                .bodytypeId(1L)
                .price(10000)
                .choiceRatio(0.11f)
                .build();
    }

    public static List<CarBodytypeEntity> generateCarBodyTypeEntities() {
        return List.of(CarBodytypeEntity.builder()
                        .carId(1L)
                        .name("name1")
                        .description("description1")
                        .image("img_url1")
                        .bodytypeId(1L)
                        .price(10000)
                        .choiceRatio(0.11f)
                        .build(),
                CarBodytypeEntity.builder()
                        .carId(1L)
                        .name("name2")
                        .description("description2")
                        .image("img_url2")
                        .bodytypeId(2L)
                        .price(20000)
                        .choiceRatio(0.21f)
                        .build()
        );
    }
}
