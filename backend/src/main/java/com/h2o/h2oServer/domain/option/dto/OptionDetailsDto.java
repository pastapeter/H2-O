package com.h2o.h2oServer.domain.option.dto;

import com.h2o.h2oServer.domain.option.entity.HashTagEntity;
import com.h2o.h2oServer.domain.option.entity.OptionDetailsEntity;
import io.swagger.annotations.ApiModel;
import lombok.Builder;
import lombok.Data;

import java.util.List;
import java.util.stream.Collectors;

@ApiModel(value = "옵션 세부 사항 정보 조회 응답")
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
    private boolean containsUseCount;

    public static OptionDetailsDto of(OptionDetailsEntity optionDetailsEntity, List<HashTagEntity> hashTagEntities) {
        OptionDetailsDtoBuilder builder = OptionDetailsDto.builder();

        if (containsHmgData(optionDetailsEntity)) {
            builder.hmgData(OptionStatisticsDto.of(optionDetailsEntity.getChoiceRatio(),
                    optionDetailsEntity.getUseCount()));
        }

        return builder
                .name(optionDetailsEntity.getName())
                .category(optionDetailsEntity.getCategory().getLabel())
                .hashTags(hashTagEntities.stream()
                        .map(hashTagEntity -> hashTagEntity.getName().getLabel())
                        .collect(Collectors.toList()))
                .image(optionDetailsEntity.getImage())
                .description(optionDetailsEntity.getDescription())
                .price(optionDetailsEntity.getPrice())
                .containsHmgData(containsHmgData(optionDetailsEntity))
                .containsUseCount(containsUseCount(optionDetailsEntity))
                .build();
    }

    private static boolean containsUseCount(OptionDetailsEntity optionDetailsEntity) {
        return optionDetailsEntity.getUseCount() != null;
    }

    private static boolean containsHmgData(OptionDetailsEntity optionDetailsEntity) {
        return optionDetailsEntity.getChoiceRatio() != null;
    }
}
