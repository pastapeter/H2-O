package com.h2o.h2oServer.domain.trim.dto;

import io.swagger.annotations.ApiModel;
import lombok.Builder;
import lombok.Data;

@ApiModel(value = "트림 가격 범위 조회 응답")
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
