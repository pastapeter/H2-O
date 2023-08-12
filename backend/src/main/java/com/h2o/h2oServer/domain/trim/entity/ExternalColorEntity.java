package com.h2o.h2oServer.domain.trim.entity;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class ExternalColorEntity {
    private Long id;
    private String name;
    private String colorCode;
    private Float choiceRatio;
    private Integer price;
}
