package com.h2o.h2oServer.domain.model_type.Entity;

import lombok.*;

@Getter
@Builder
@EqualsAndHashCode
public class PowertrainEntity {
    private Long id;
    private String name;
    private String description;
    private String image;
}
