package com.h2o.h2oServer.domain.options.dto;

import lombok.Data;

@Data
public class DefaultOptionRangeDto {
    private Long from;
    private Long count;

    private DefaultOptionRangeDto(Long from, Long count) {
        this.from = from;
        this.count = count;
    }

    public static DefaultOptionRangeDto of(Long from, Long count) {
        return new DefaultOptionRangeDto(from, count);
    }
}
