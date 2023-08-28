package com.h2o.h2oServer.domain.model_type.dto;

import com.h2o.h2oServer.domain.model_type.Entity.PowertrainOutputEntity;
import io.swagger.annotations.ApiModel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@ApiModel(value = "차량 모델 타입 정보 조회 응답 - 파워트레인 출력 정보")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class PowertrainOutputDto {
    private Float output;
    private Integer minRpm;
    private Integer maxRpm;

    public static PowertrainOutputDto of(PowertrainOutputEntity powertrainOutputEntity) {
        return new PowertrainOutputDto(
                powertrainOutputEntity.getOutput(),
                powertrainOutputEntity.getMinRpm(),
                powertrainOutputEntity.getMaxRpm()
        );
    }
}
