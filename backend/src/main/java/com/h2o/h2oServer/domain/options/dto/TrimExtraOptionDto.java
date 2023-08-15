package com.h2o.h2oServer.domain.options.dto;

import com.h2o.h2oServer.domain.option.entity.HashTagEntity;
import com.h2o.h2oServer.domain.options.entity.TrimExtraOptionEntity;
import lombok.Data;

import java.util.List;
import java.util.stream.Collectors;

@Data
public class TrimExtraOptionDto {
    private Long id;
    private String category;
    private String name;
    private String image;
    private Integer price;
    private boolean containsHmgData;
    private Boolean isPackage;
    private Integer choiceRatio;
    private List<String> hashTags;

    private TrimExtraOptionDto(boolean isPackage, Long id, String category, String name, String image,
                               Integer price, List<String> hashTags) {
        this.id = id;
        this.category = category;
        this.name = name;
        this.image = image;
        this.price = price;
        this.isPackage = isPackage;
        this.hashTags = hashTags;
    }

    public static TrimExtraOptionDto of(boolean isPackage, TrimExtraOptionEntity trimExtraOptionEntity, List<HashTagEntity> hashTagEntities) {
        TrimExtraOptionDto trimExtraOptionDto = new TrimExtraOptionDto(
                isPackage,
                trimExtraOptionEntity.getId(),
                trimExtraOptionEntity.getCategory().getLabel(),
                trimExtraOptionEntity.getName(),
                trimExtraOptionEntity.getImage(),
                trimExtraOptionEntity.getPrice(),
                hashTagEntities.stream()
                        .map(hashTagEntity -> hashTagEntity.getName().getLabel())
                        .collect(Collectors.toList())
        );

        Float choiceRatio = trimExtraOptionEntity.getChoiceRatio();
        if (choiceRatio != null) {
            trimExtraOptionDto.containsHmgData = true;
            trimExtraOptionDto.choiceRatio = Math.round(choiceRatio * 100);
        }

        return trimExtraOptionDto;
    }
}
