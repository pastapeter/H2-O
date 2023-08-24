package com.h2o.h2oServer.domain.trim.entity;

import lombok.Builder;
import lombok.Data;

import java.io.Serializable;

@Data
@Builder
public class OptionStatisticsEntity implements Serializable {
    private Long id;
    private String name;
    private Float useCount;
}
