package com.h2o.h2oServer.domain.model_type.dto;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import java.util.List;

@ApiModel(value = "차량 모델 타입 정보 조회 응답")
@Data
public class ModelTypeDto {
    private List<CarPowertrainDto> powertrains;
    private List<CarBodytypeDto> bodytypes;
    private List<CarDrivetrainDto> drivetrains;

    private ModelTypeDto(
            List<CarPowertrainDto> powertrains,
            List<CarBodytypeDto> bodytypes,
            List<CarDrivetrainDto> drivetrains
    ) {
        this.powertrains = powertrains;
        this.bodytypes = bodytypes;
        this.drivetrains = drivetrains;
    }

    public static ModelTypeDto of(
            List<CarPowertrainDto> powertrains,
            List<CarBodytypeDto> bodytypes,
            List<CarDrivetrainDto> drivetrains
    ) {
        return new ModelTypeDto(powertrains, bodytypes, drivetrains);
    }
}
