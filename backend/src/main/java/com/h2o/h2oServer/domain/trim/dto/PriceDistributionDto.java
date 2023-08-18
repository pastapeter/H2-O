package com.h2o.h2oServer.domain.trim.dto;

import io.swagger.annotations.ApiModel;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@ApiModel(value = "트림 가격 분포 정보 조회 응답")
@Data
@Builder
public class PriceDistributionDto {
    Integer unit;
    List<Integer> quantityPerUnit;

    public static PriceDistributionDto of(Integer unit, List<Integer> quantityPerUnit) {
        return new PriceDistributionDto(unit, quantityPerUnit);
    }
}
