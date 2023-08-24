package com.h2o.h2oServer.domain.model_type.dto;

import com.h2o.h2oServer.domain.model_type.Entity.CarPowertrainEntity;
import com.h2o.h2oServer.domain.model_type.Entity.PowertrainOutputEntity;
import com.h2o.h2oServer.domain.model_type.Entity.PowertrainTorqueEntity;
import io.swagger.annotations.ApiModel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@ApiModel(value = "차량 모델 타입 정보 조회 응답 - 파워트레인 타입 정보")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class CarPowertrainDto {
    private Long id;
    private String name;
    private Integer price;
    private Integer choiceRatio;
    private String description;
    private String image;
    private PowertrainOutputDto maxOutput;
    private PowertrainTorqueDto maxTorque;

    public static CarPowertrainDto of(
            CarPowertrainEntity carPowerTrainEntity,
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
