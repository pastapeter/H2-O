package com.h2o.h2oServer.domain.model_type.dto;

import io.swagger.annotations.ApiModel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@ApiModel(value = "차량 모델 타입 정보 조회 응답")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ModelTypeDto {
    private List<CarPowertrainDto> powertrains;
    private List<CarBodytypeDto> bodytypes;
    private List<CarDrivetrainDto> drivetrains;

    public static ModelTypeDto of(
            List<CarPowertrainDto> powertrains,
            List<CarBodytypeDto> bodytypes,
            List<CarDrivetrainDto> drivetrains
    ) {
        return new ModelTypeDto(powertrains, bodytypes, drivetrains);
    }
}
