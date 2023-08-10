package com.h2o.h2oServer.domain.trim.entity;

import lombok.*;


@Data
@Builder
public class TrimEntity {
    private Long id;
    private String name;
    private String description;
    private Integer price;
}
