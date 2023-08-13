package com.h2o.h2oServer.domain.model_type.dto;

import lombok.Data;

import java.util.List;

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
