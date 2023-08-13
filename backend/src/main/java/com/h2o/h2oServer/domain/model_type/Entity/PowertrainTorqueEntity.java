package com.h2o.h2oServer.domain.model_type.Entity;

import lombok.*;

@Getter
@Builder
@EqualsAndHashCode
public class PowertrainTorqueEntity {
    private Long powertrainId;
    private Float torque;
    private Integer minRpm;
    private Integer maxRpm;
}
