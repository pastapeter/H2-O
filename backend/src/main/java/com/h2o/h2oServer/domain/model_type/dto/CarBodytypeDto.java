package com.h2o.h2oServer.domain.model_type.dto;

import com.h2o.h2oServer.domain.model_type.Entity.CarBodytypeEntity;
import io.swagger.annotations.ApiModel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@ApiModel(value = "차량 모델 타입 정보 조회 응답 - 바디 타입 정보")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class CarBodytypeDto {
    private Long id;
    private String name;
    private String description;
    private String image;
    private Integer price;
    private Integer choiceRatio;

    public static CarBodytypeDto of(CarBodytypeEntity carBodytypeEntity) {
        return new CarBodytypeDto(
                carBodytypeEntity.getBodytypeId(),
                carBodytypeEntity.getName(),
                carBodytypeEntity.getDescription(),
                carBodytypeEntity.getImage(),
                carBodytypeEntity.getPrice(),
                Math.round(carBodytypeEntity.getChoiceRatio() * 100)
        );
    }

    public static List<CarBodytypeDto> listOf(List<CarBodytypeEntity> carBodytypeEntities) {
        List<CarBodytypeDto> carBodytypeDtos = new ArrayList<>();

        for (CarBodytypeEntity carBodytypeEntity : carBodytypeEntities) {
            carBodytypeDtos.add(CarBodytypeDto.of(carBodytypeEntity));
        }

        return carBodytypeDtos;
    }
}
