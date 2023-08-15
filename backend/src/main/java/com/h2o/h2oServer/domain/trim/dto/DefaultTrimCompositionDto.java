package com.h2o.h2oServer.domain.trim.dto;

import com.h2o.h2oServer.domain.model_type.dto.CarBodytypeDto;
import com.h2o.h2oServer.domain.model_type.dto.CarDrivetrainDto;
import com.h2o.h2oServer.domain.model_type.dto.CarPowertrainDto;
import io.swagger.annotations.ApiModel;
import lombok.Builder;
import lombok.Data;

@ApiModel(value = "트림 기본 구성 정보 조회 응답")
@Data
@Builder
public class DefaultTrimCompositionDto {
    private CarPowertrainDto powertrain;
    private CarBodytypeDto bodytype;
    private CarDrivetrainDto drivetrain;
    private InternalColorDto internalColor;
    private ExternalColorDto externalColor;
}
