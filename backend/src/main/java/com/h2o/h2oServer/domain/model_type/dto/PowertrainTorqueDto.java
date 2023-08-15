package com.h2o.h2oServer.domain.model_type.dto;

import com.h2o.h2oServer.domain.model_type.Entity.PowertrainTorqueEntity;
import io.swagger.annotations.ApiModel;
import lombok.Data;

@ApiModel(value = "차량 모델 타입 정보 조회 응답 - 파워트레인 토크 정보")
@Data
public class PowertrainTorqueDto {
    private Float torque;
    private Integer minRpm;
    private Integer maxRpm;

    private PowertrainTorqueDto(Float torque, Integer minRpm, Integer maxRpm) {
        this.torque = torque;
        this.minRpm = minRpm;
        this.maxRpm = maxRpm;
    }

    public static PowertrainTorqueDto of(PowertrainTorqueEntity powertrainTorqueEntity) {
        return new PowertrainTorqueDto(
                powertrainTorqueEntity.getTorque(),
                powertrainTorqueEntity.getMinRpm(),
                powertrainTorqueEntity.getMaxRpm()
        );
    }
}
