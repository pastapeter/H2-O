package com.h2o.h2oServer.domain.option.dto;

import io.swagger.annotations.ApiModel;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;

@ApiModel(value = "옵션 세부 정보 조회 응답 - hmg Data 정보")
@Builder
@Getter
@EqualsAndHashCode
public class OptionStatisticsDto {
    public static final int SELL_NUMBER = 3509;
    private boolean isOverHalf;
    private Integer choiceCount;
    private Float useCount;

    public static OptionStatisticsDto of(Float choiceRatio, Float useCount) {
        return OptionStatisticsDto.builder()
                .isOverHalf(choiceRatio > 0.5)
                .useCount(useCount)
                .choiceCount(Math.round(choiceRatio * SELL_NUMBER))
                .build();
    }
}
