package com.h2o.h2oServer.domain.options.dto;

import lombok.Data;

@Data
public class PageRangeDto {
    private Long from;
    private Long count;

    private PageRangeDto(Long from, Long count) {
        this.from = from;
        this.count = count;
    }

    public static PageRangeDto of(Long from, Long count) {
        return new PageRangeDto(from, count);
    }
}
