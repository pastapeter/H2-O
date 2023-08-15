package com.h2o.h2oServer.domain.trim.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class PriceRangeDto {
    private Integer maxPrice;
    private Integer minPrice;

    public static PriceRangeDto of(Integer maxPrice, Integer minPrice) {
        return PriceRangeDto.builder()
                .maxPrice(maxPrice)
                .minPrice(minPrice)
                .build();
    }
}
