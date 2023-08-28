package com.h2o.h2oServer.domain.option.dto;

import com.h2o.h2oServer.domain.option.dto.OptionStatisticsDto.OptionStatisticsDtoBuilder;
import com.h2o.h2oServer.domain.option.entity.HashTagEntity;
import com.h2o.h2oServer.domain.option.entity.OptionDetailsEntity;
import io.swagger.annotations.ApiModel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.stream.Collectors;

import static com.h2o.h2oServer.domain.option.dto.OptionStatisticsDto.SELL_NUMBER;

@ApiModel(value = "옵션 세부 사항 정보 조회 응답")
@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class OptionDetailsDto {
    private String name;
    private String category;
    private List<String> hashTags;
    private String image;
    private String pcImage;
    private String mobileImage;
    private String description;
    private OptionStatisticsDto hmgData;
    private Integer price;
    private boolean containsChoiceCount;
    private boolean containsUseCount;

    public static OptionDetailsDto of(OptionDetailsEntity optionDetailsEntity, List<HashTagEntity> hashTagEntities) {
        OptionDetailsDtoBuilder builder = OptionDetailsDto.builder();
        OptionStatisticsDtoBuilder optionStatisticsDtoBuilder = OptionStatisticsDto.builder();

        if (containsChoiceRatio(optionDetailsEntity)) {
            optionStatisticsDtoBuilder.choiceCount(Math.round(optionDetailsEntity.getChoiceRatio() * SELL_NUMBER));
            optionStatisticsDtoBuilder.isOverHalf(optionDetailsEntity.getChoiceRatio() > 0.5);
        }

        if (containsUseCount(optionDetailsEntity)) {
            optionStatisticsDtoBuilder.useCount(Math.round(optionDetailsEntity.getUseCount()));
        }

        return builder
                .name(optionDetailsEntity.getName())
                .category(optionDetailsEntity.getCategory().getLabel())
                .hashTags(hashTagEntities.stream()
                        .map(hashTagEntity -> hashTagEntity.getName().getLabel())
                        .collect(Collectors.toList()))
                .image(optionDetailsEntity.getImage())
                .pcImage(optionDetailsEntity.getPcImage())
                .mobileImage(optionDetailsEntity.getMobileImage())
                .description(optionDetailsEntity.getDescription())
                .price(optionDetailsEntity.getPrice())
                .containsChoiceCount(containsChoiceRatio(optionDetailsEntity))
                .containsUseCount(containsUseCount(optionDetailsEntity))
                .hmgData(optionStatisticsDtoBuilder.build())
                .build();
    }

    private static boolean containsUseCount(OptionDetailsEntity optionDetailsEntity) {
        return optionDetailsEntity.getUseCount() != null;
    }

    private static boolean containsChoiceRatio(OptionDetailsEntity optionDetailsEntity) {
        return optionDetailsEntity.getChoiceRatio() != null;
    }
}
