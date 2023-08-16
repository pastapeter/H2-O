package com.h2o.h2oServer.domain.trim.dto;

import com.h2o.h2oServer.domain.trim.entity.OptionStatisticsEntity;
import io.swagger.annotations.ApiModel;
import lombok.Builder;
import lombok.Getter;

import java.util.List;
import java.util.stream.Collectors;

@ApiModel(value = "트림 정보 조회 응답 - hmg data")
@Builder
@Getter
public class TrimStatisticsDto {
    private String dataLabel;
    private Integer frequency;

    public static TrimStatisticsDto of(OptionStatisticsEntity entity) {
        return TrimStatisticsDto.builder()
                .dataLabel(entity.getName())
                .frequency(Math.round(entity.getUseCount()))
                .build();
    }

    public static List<TrimStatisticsDto> ListOf(List<OptionStatisticsEntity> entities) {
        return entities.stream()
                .map(TrimStatisticsDto::of)
                .collect(Collectors.toList());
    }
}
