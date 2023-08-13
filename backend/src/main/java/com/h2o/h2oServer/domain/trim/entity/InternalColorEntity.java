package com.h2o.h2oServer.domain.trim.entity;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class InternalColorEntity {
    private Long id;
    private String name;
    private String fabricImage;
    private String internalImage;
    private Integer price;
    private Float choiceRatio;
}
