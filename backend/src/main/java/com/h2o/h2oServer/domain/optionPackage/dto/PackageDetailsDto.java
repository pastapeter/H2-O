package com.h2o.h2oServer.domain.optionPackage.dto;

import com.h2o.h2oServer.domain.option.dto.OptionDto;
import com.h2o.h2oServer.domain.option.entity.HashTagEntity;
import com.h2o.h2oServer.domain.option.entity.enums.HashTag;
import com.h2o.h2oServer.domain.optionPackage.entity.PackageEntity;
import io.swagger.annotations.ApiModel;
import lombok.Builder;
import lombok.Data;

import java.util.List;
import java.util.stream.Collectors;

import static com.h2o.h2oServer.domain.option.dto.OptionStatisticsDto.SELL_NUMBER;

@ApiModel(value = "패키지 세부 정보 조회 응답")
@Builder
@Data
public class PackageDetailsDto {
    private String name;
    private String category;
    private Integer price;
    private Integer choiceRatio;
    private Integer choiceCount;
    private Boolean isOverHalf;
    private List<String> hashTags;
    private List<OptionDto> components;

    public static PackageDetailsDto of(PackageEntity packageEntity,
                                       List<HashTagEntity> hashTagEntities,
                                       List<OptionDto> optionDtos) {
        Integer choiceCount = Math.round(packageEntity.getChoiceRatio() * SELL_NUMBER);
        return PackageDetailsDto.builder()
                .name(packageEntity.getName())
                .category(packageEntity.getCategory().getLabel())
                .price(packageEntity.getPrice())
                .choiceRatio(Math.round(packageEntity.getChoiceRatio() * 100))
                .choiceCount(choiceCount)
                .isOverHalf(choiceCount > SELL_NUMBER / 2)
                .hashTags(hashTagEntities.stream()
                        .map(HashTagEntity::getName)
                        .map(HashTag::getLabel)
                        .collect(Collectors.toList()))
                .components(optionDtos)
                .build();
    }
}
