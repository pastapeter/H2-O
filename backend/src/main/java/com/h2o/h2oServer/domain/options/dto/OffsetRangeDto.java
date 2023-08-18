package com.h2o.h2oServer.domain.options.dto;

import lombok.Data;

@Data
public class OffsetRangeDto {
    private Long startOffset;
    private Long endOffset;

    private OffsetRangeDto(Long startOffset, Long endOffset) {
        this.startOffset = startOffset;
        this.endOffset = endOffset;
    }

    public static OffsetRangeDto of(Long countRow) {
        return new OffsetRangeDto(0L, countRow - 1);
    }
}
