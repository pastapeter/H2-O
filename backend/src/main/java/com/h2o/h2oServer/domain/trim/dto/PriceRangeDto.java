package com.h2o.h2oServer.domain.trim.dto;

import io.swagger.annotations.ApiModel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@ApiModel(value = "트림 가격 범위 조회 응답")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
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
