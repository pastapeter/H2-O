package com.h2o.h2oServer.domain.option.dto;

import com.h2o.h2oServer.domain.option.entity.HashTagEntity;
import com.h2o.h2oServer.domain.option.entity.OptionDetailsEntity;
import lombok.Builder;
import lombok.Data;

import java.util.List;
import java.util.stream.Collectors;

@Builder
@Data
public class OptionDetailsDto {
    private String name;
    private String category;
    private List<String> hashTags;
    private String image;
    private String description;
    private OptionStatisticsDto hmgData;
    private Integer price;
    private boolean containsHmgData;

    public static OptionDetailsDto of(OptionDetailsEntity optionDetailsEntity, List<HashTagEntity> hashTagEntities) {
        return OptionDetailsDto.builder()
                .name(optionDetailsEntity.getName())
                .category(optionDetailsEntity.getCategory().getLabel())
                .hashTags(hashTagEntities.stream()
                        .map(hashTagEntity -> hashTagEntity.getName().getLabel())
                        .collect(Collectors.toList()))
                .image(optionDetailsEntity.getImage())
                .description(optionDetailsEntity.getDescription())
                .hmgData(OptionStatisticsDto.of(optionDetailsEntity.getChoiceRatio(),
                        optionDetailsEntity.getUseCount()))
                .price(optionDetailsEntity.getPrice())
                .containsHmgData(containsHmgData(optionDetailsEntity))
                .build();
    }

    private static boolean containsHmgData(OptionDetailsEntity optionDetailsEntity) {
        return optionDetailsEntity.getChoiceRatio() != null;
    }
}
