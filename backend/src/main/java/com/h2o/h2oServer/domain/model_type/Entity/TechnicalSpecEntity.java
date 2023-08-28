package com.h2o.h2oServer.domain.model_type.Entity;

import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;

@Getter
@Builder
@EqualsAndHashCode
public class TechnicalSpecEntity {
    private Long powertrainId;
    private Long drivetrainId;
    private Integer displacement;
    private Float fuelEfficiency;
}
