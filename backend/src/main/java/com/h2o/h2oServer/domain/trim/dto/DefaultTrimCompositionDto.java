package com.h2o.h2oServer.domain.trim.dto;

import com.h2o.h2oServer.domain.model_type.dto.CarBodytypeDto;
import com.h2o.h2oServer.domain.model_type.dto.CarDrivetrainDto;
import com.h2o.h2oServer.domain.model_type.dto.CarPowertrainDto;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class DefaultTrimCompositionDto {
    private CarPowertrainDto powertrain;
    private CarBodytypeDto bodytype;
    private CarDrivetrainDto drivetrain;
    private InternalColorDto internalColor;
    private ExternalColorDto externalColor;
}
