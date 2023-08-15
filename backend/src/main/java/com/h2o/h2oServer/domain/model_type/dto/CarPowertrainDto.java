package com.h2o.h2oServer.domain.model_type.dto;

import com.h2o.h2oServer.domain.model_type.Entity.CarPowerTrainEntity;
import com.h2o.h2oServer.domain.model_type.Entity.PowertrainOutputEntity;
import com.h2o.h2oServer.domain.model_type.Entity.PowertrainTorqueEntity;
import io.swagger.annotations.ApiModel;
import lombok.Data;

@ApiModel(value = "차량 모델 타입 정보 조회 응답 - 파워트레인 타입 정보")
@Data
public class CarPowertrainDto {
    private Long id;
    private String name;
    private Integer price;
    private Integer choiceRatio;
    private String description;
    private String image;
    private PowertrainOutputDto maxOutput;
    private PowertrainTorqueDto maxTorque;

    private CarPowertrainDto(Long id, String name, Integer price, Integer choiceRatio, String description, String image,
                            PowertrainOutputDto maxOutput, PowertrainTorqueDto maxTorque) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.choiceRatio = choiceRatio;
        this.description = description;
        this.image = image;
        this.maxOutput = maxOutput;
        this.maxTorque = maxTorque;
    }

    public static CarPowertrainDto of(
            CarPowerTrainEntity carPowerTrainEntity,
            PowertrainOutputEntity powertrainOutputEntity,
            PowertrainTorqueEntity powertrainTorqueEntity
    ) {

        return new CarPowertrainDto(
                carPowerTrainEntity.getPowertrainId(),
                carPowerTrainEntity.getName(),
                carPowerTrainEntity.getPrice(),
                Math.round(carPowerTrainEntity.getChoiceRatio() * 100),
                carPowerTrainEntity.getDescription(),
                carPowerTrainEntity.getImage(),
                PowertrainOutputDto.of(powertrainOutputEntity),
                PowertrainTorqueDto.of(powertrainTorqueEntity)
        );

    }
}
