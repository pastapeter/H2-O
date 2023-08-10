package com.h2o.h2oServer.domain.trim.entity;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class OptionStatisticsEntity {
    private Long id;
    private String name;
    private Float useCount;
}
