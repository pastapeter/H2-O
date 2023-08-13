package com.h2o.h2oServer.domain.model_type.dto;

import com.h2o.h2oServer.domain.model_type.Entity.CarDrivetrainEntity;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class CarDrivetrainDto {
    private Long id;
    private String name;
    private String description;
    private String image;
    private Integer price;
    private Integer choiceRatio;

    private CarDrivetrainDto(Long id, String name, String description, String image, Integer price, Integer choiceRatio) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.image = image;
        this.price = price;
        this.choiceRatio = choiceRatio;
    }

    public static CarDrivetrainDto of(CarDrivetrainEntity carDrivetrainEntity) {
        return new CarDrivetrainDto(
                carDrivetrainEntity.getDrivetrainId(),
                carDrivetrainEntity.getName(),
                carDrivetrainEntity.getDescription(),
                carDrivetrainEntity.getImage(),
                carDrivetrainEntity.getPrice(),
                Math.round(carDrivetrainEntity.getChoiceRatio() * 100)
        );
    }

    public static List<CarDrivetrainDto> listOf(List<CarDrivetrainEntity> carDrivetrainEntities) {
        List<CarDrivetrainDto> carDrivetrainDtos = new ArrayList<>();

        for (CarDrivetrainEntity carDrivetrainEntity : carDrivetrainEntities) {
            carDrivetrainDtos.add(CarDrivetrainDto.of(carDrivetrainEntity));
        }

        return carDrivetrainDtos;
    }
}
