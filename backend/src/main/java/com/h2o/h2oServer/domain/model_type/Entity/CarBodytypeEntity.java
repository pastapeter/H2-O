package com.h2o.h2oServer.domain.model_type.Entity;

import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;

@Getter
@Builder
@EqualsAndHashCode
public class CarBodytypeEntity {
    private Long carId;
    private Long bodytypeId;
    private String name;
    private String description;
    private String image;
    private Integer price;
    private Float choiceRatio;
}
