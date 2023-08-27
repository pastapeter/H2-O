package com.h2o.h2oServer.domain.option.dto;

import lombok.Data;

@Data
public class DefaultOptionSizeDto {
    private Long startIndex;
    private Long size;

    private DefaultOptionSizeDto(Long startIndex, Long size) {
        this.startIndex = startIndex;
        this.size = size;
    }

    public static DefaultOptionSizeDto of(Long countRow) {
        return new DefaultOptionSizeDto(0L, countRow);
    }
}
