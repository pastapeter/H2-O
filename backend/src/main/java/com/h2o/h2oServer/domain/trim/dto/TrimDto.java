package com.h2o.h2oServer.domain.trim.dto;

import com.h2o.h2oServer.domain.trim.entity.ImageEntity;
import com.h2o.h2oServer.domain.trim.entity.OptionStatisticsEntity;
import com.h2o.h2oServer.domain.trim.entity.TrimEntity;
import lombok.Builder;
import lombok.Getter;

import java.util.List;
import java.util.stream.Collectors;

@Builder
@Getter
public class TrimDto {
    private Long id;
    private String name;
    private String description;
    private Integer price;
    private List<String> images;
    private List<TrimStatisticsDto> options;

    public static TrimDto of(TrimEntity trimEntity,
                     List<ImageEntity> imageEntities,
                     List<OptionStatisticsEntity> optionStatisticsEntities) {
        return TrimDto.builder()
                .id(trimEntity.getId())
                .name(trimEntity.getName())
                .description(trimEntity.getDescription())
                .price(trimEntity.getPrice())
                .images(imageEntities.stream()
                        .map(ImageEntity::getImage)
                        .collect(Collectors.toList()))
                .options(TrimStatisticsDto.ListOf(optionStatisticsEntities))
                .build();
    }
}
