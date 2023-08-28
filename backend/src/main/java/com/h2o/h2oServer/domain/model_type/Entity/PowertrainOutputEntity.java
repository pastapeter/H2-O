package com.h2o.h2oServer.domain.model_type.Entity;

import lombok.*;

@Getter
@Builder
@EqualsAndHashCode
public class PowertrainOutputEntity {
    private Long powertrainId;
    private Float output;
    private Integer minRpm;
    private Integer maxRpm;
}
