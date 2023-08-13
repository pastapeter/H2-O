package com.h2o.h2oServer.domain.model_type.dto;

import com.h2o.h2oServer.domain.model_type.Entity.PowertrainOutputEntity;
import lombok.Data;


@Data
public class PowertrainOutputDto {
    private Float output;
    private Integer minRpm;
    private Integer maxRpm;

    private PowertrainOutputDto(Float output, Integer minRpm, Integer maxRpm) {
        this.output = output;
        this.minRpm = minRpm;
        this.maxRpm = maxRpm;
    }

    public static PowertrainOutputDto of(PowertrainOutputEntity powertrainOutputEntity) {
        return new PowertrainOutputDto(
                powertrainOutputEntity.getOutput(),
                powertrainOutputEntity.getMinRpm(),
                powertrainOutputEntity.getMaxRpm()
        );
    }
}
