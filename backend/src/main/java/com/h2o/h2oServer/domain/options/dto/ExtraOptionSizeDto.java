package com.h2o.h2oServer.domain.options.dto;

import lombok.Data;

@Data
public class ExtraOptionSizeDto {
    private Long packageStartIndex;
    private Long packageSize;
    private Long optionStartIndex;
    private Long optionSize;

    private ExtraOptionSizeDto(Long packageStartIndex, Long packageSize, Long optionStartIndex, Long optionSize) {
        this.packageStartIndex = packageStartIndex;
        this.packageSize = packageSize;
        this.optionStartIndex = optionStartIndex;
        this.optionSize = optionSize;
    }

    public static ExtraOptionSizeDto of(Long packageSize, Long optionSize) {
        return new ExtraOptionSizeDto(0L, packageSize, 0L, optionSize);
    }
}
