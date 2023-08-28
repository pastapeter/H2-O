package com.h2o.h2oServer.domain.model_type.dto;

import com.h2o.h2oServer.domain.model_type.Entity.PowertrainTorqueEntity;
import io.swagger.annotations.ApiModel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@ApiModel(value = "차량 모델 타입 정보 조회 응답 - 파워트레인 토크 정보")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class PowertrainTorqueDto {
    private Float torque;
    private Integer minRpm;
    private Integer maxRpm;

    public static PowertrainTorqueDto of(PowertrainTorqueEntity powertrainTorqueEntity) {
        return new PowertrainTorqueDto(
                powertrainTorqueEntity.getTorque(),
                powertrainTorqueEntity.getMinRpm(),
                powertrainTorqueEntity.getMaxRpm()
        );
    }
}
