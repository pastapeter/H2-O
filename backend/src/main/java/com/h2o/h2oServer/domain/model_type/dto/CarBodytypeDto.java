package com.h2o.h2oServer.domain.model_type.dto;

import com.h2o.h2oServer.domain.model_type.Entity.CarBodytypeEntity;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class CarBodytypeDto {
    private Long id;
    private String name;
    private String description;
    private String image;
    private Integer price;
    private Integer choiceRatio;

    private CarBodytypeDto(Long id, String name, String description, String image, Integer price, Integer choiceRatio) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.image = image;
        this.price = price;
        this.choiceRatio = choiceRatio;
    }

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
