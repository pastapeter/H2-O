package com.h2o.h2oServer.domain.model_type.Entity;

import lombok.*;

@Getter
@Builder
@EqualsAndHashCode
public class CarDrivetrainEntity {
    private Long carId;
    private Long drivetrainId;
    private String name;
    private String description;
    private String image;
    private Integer price;
    private Float choiceRatio;
}
