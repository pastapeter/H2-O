package com.h2o.h2oServer.domain.trim.entity;

import lombok.*;

import java.io.Serializable;


@Data
@Builder
public class TrimEntity implements Serializable {
    private Long id;
    private String name;
    private String description;
    private Integer price;
    private Long carId;
}
