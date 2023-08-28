package com.h2o.h2oServer.domain.model_type;

import com.h2o.h2oServer.domain.model_type.Entity.BodytypeEntity;
import com.h2o.h2oServer.domain.model_type.Entity.CarBodytypeEntity;
import com.h2o.h2oServer.domain.model_type.dto.CarBodytypeDto;
import com.h2o.h2oServer.domain.model_type.dto.ModelTypeIdDto;
import com.h2o.h2oServer.domain.quotation.dto.QuotationRequestDto;

import java.util.List;

public class BodytypeFixture {

    public static BodytypeEntity generateBodytypeEntity() {
        return BodytypeEntity.builder()
                .id(1L)
                .name("name1")
                .description("description1")
                .image("img_url1")
                .build();
    }

    public static QuotationRequestDto generateQuotationRequestDto() {
        return QuotationRequestDto.builder()
                .carId(4L)
                .trimId(5L)
                .modelTypeIds(ModelTypeIdDto.builder()
                        .bodytypeId(2L)
                        .drivetrainId(3L)
                        .powertrainId(1L)
                        .build())
                .externalColorId(7L)
                .internalColorId(6L)
                .optionIds(List.of(8L, 9L, 10L))
                .packageIds(List.of(11L))
                .build();
    }

    public static CarBodytypeEntity generateCarBodytypeEntity() {
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

    public static List<CarBodytypeEntity> generateCarBodytypeEntities() {
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

    public static List<CarBodytypeEntity> generateCarBodyTypeEntities(Long carId) {
        return List.of(CarBodytypeEntity.builder()
                        .carId(carId)
                        .name("name1")
                        .description("description1")
                        .image("img_url1")
                        .bodytypeId(1L)
                        .price(10000)
                        .choiceRatio(0.11f)
                        .build(),
                CarBodytypeEntity.builder()
                        .carId(carId)
                        .name("name2")
                        .description("description2")
                        .image("img_url2")
                        .bodytypeId(2L)
                        .price(20000)
                        .choiceRatio(0.21f)
                        .build()
        );
    }

    public static CarBodytypeDto generateCarBodytypeDto() {
        return CarBodytypeDto.of(generateCarBodyTypeEntity());
    }
}

