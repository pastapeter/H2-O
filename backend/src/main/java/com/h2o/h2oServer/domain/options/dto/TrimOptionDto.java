package com.h2o.h2oServer.domain.options.dto;

import com.h2o.h2oServer.domain.option.entity.HashTagEntity;
import com.h2o.h2oServer.domain.option.entity.enums.OptionCategory;
import com.h2o.h2oServer.domain.options.entity.TrimOptionEntity;
import lombok.Data;

import java.util.List;
import java.util.stream.Collectors;

@Data
public class TrimOptionDto {
    private boolean isPackage;
    private Long id;
    private String category;
    private String name;
    private String image;
    private Integer price;
    private boolean containsHmgData;
    private Integer choiceRatio;
    private List<String> hashTags;

    private TrimOptionDto(boolean isPackage, Long id, String category, String name, String image,
                          Integer price, List<String> hashTags) {
        this.isPackage = isPackage;
        this.id = id;
        this.category = category;
        this.name = name;
        this.image = image;
        this.price = price;
        this.hashTags = hashTags;
    }

    public static TrimOptionDto of(boolean isPackage,
                                   TrimOptionEntity trimOptionEntity, List<HashTagEntity> hashTagEntities) {
        TrimOptionDto trimOptionDto = new TrimOptionDto(
                isPackage,
                trimOptionEntity.getId(),
                trimOptionEntity.getCategory().getLabel(),
                trimOptionEntity.getName(),
                trimOptionEntity.getImage(),
                trimOptionEntity.getPrice(),
                hashTagEntities.stream()
                        .map(hashTagEntity -> hashTagEntity.getName().getLabel())
                        .collect(Collectors.toList())
        );

        Float choiceRatio = trimOptionEntity.getChoiceRatio();
        if (choiceRatio != null) {
            trimOptionDto.containsHmgData = true;
            trimOptionDto.choiceRatio = Math.round(choiceRatio * 100);
        }

        return trimOptionDto;
    }
}
