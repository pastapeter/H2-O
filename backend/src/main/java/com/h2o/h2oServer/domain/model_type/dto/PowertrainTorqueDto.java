package com.h2o.h2oServer.domain.model_type.dto;

import com.h2o.h2oServer.domain.model_type.Entity.PowertrainTorqueEntity;
import lombok.Data;

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
