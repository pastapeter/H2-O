package com.h2o.h2oServer.domain.trim.dto;

import com.h2o.h2oServer.domain.trim.entity.OptionStatisticsEntity;
import lombok.Builder;
import lombok.Getter;

import java.util.List;
import java.util.stream.Collectors;

@Builder
@Getter
public class TrimStatisticsDto {
    private String dataLabel;
    private Float frequency;

    public static TrimStatisticsDto of(OptionStatisticsEntity entity) {
        return TrimStatisticsDto.builder()
                .dataLabel(entity.getName())
                .frequency(entity.getUseCount())
                .build();
    }

    public static List<TrimStatisticsDto> ListOf(List<OptionStatisticsEntity> entities) {
        return entities.stream()
                .map(TrimStatisticsDto::of)
                .collect(Collectors.toList());
    }
}
