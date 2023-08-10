package com.h2o.h2oServer.domain.trim.dto;

import com.h2o.h2oServer.domain.trim.entity.OptionStatisticsEntity;
import lombok.Builder;
import lombok.Getter;

import java.util.List;
import java.util.stream.Collectors;

@Builder
@Getter
public class OptionStatisticsDto {
    private String dataLabel;
    private Float frequency;

    public static OptionStatisticsDto of(OptionStatisticsEntity entity) {
        return OptionStatisticsDto.builder()
                .dataLabel(entity.getName())
                .frequency(entity.getUseCount())
                .build();
    }

    public static List<OptionStatisticsDto> ListOf(List<OptionStatisticsEntity> entities) {
        return entities.stream()
                .map(OptionStatisticsDto::of)
                .collect(Collectors.toList());
    }
}
