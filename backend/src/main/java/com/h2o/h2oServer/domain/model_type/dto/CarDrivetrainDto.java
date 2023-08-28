package com.h2o.h2oServer.domain.model_type.dto;

import com.h2o.h2oServer.domain.model_type.Entity.CarDrivetrainEntity;
import io.swagger.annotations.ApiModel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@ApiModel(value = "차량 모델 타입 정보 조회 응답 - 구동 방식 정보")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class CarDrivetrainDto {
    private Long id;
    private String name;
    private String description;
    private String image;
    private Integer price;
    private Integer choiceRatio;

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
