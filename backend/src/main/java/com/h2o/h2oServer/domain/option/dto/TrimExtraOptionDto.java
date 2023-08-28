package com.h2o.h2oServer.domain.option.dto;

import com.h2o.h2oServer.domain.option.entity.HashTagEntity;
import com.h2o.h2oServer.domain.option.entity.TrimExtraOptionEntity;
import io.swagger.annotations.ApiModel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@ApiModel(value = "트림 추가 옵션 정보 조회 응답")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class TrimExtraOptionDto {
    private Long id;
    private String category;
    private String name;
    private String image;
    private String pcImage;
    private String mobileImage;
    private Integer price;
    private boolean containsHmgData;
    private Boolean isPackage;
    private Integer choiceRatio;
    private List<String> hashTags;

    private TrimExtraOptionDto(boolean isPackage, Long id, String category, String name,
                               String image, String pcImage, String mobileImage, Integer price,
                               List<String> hashTags) {
        this.id = id;
        this.category = category;
        this.name = name;
        this.image = image;
        this.pcImage = pcImage;
        this.mobileImage = mobileImage;
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
                trimExtraOptionEntity.getPcImage(),
                trimExtraOptionEntity.getMobileImage(),
                trimExtraOptionEntity.getPrice(),
                hashTagEntities.stream()
                        .map(hashTagEntity -> hashTagEntity.getName().getLabel())
                        .collect(Collectors.toList())
        );

        Collections.sort(trimExtraOptionDto.hashTags);

        Float choiceRatio = trimExtraOptionEntity.getChoiceRatio();
        if (choiceRatio != null) {
            trimExtraOptionDto.containsHmgData = true;
            trimExtraOptionDto.choiceRatio = Math.round(choiceRatio * 100);
        }

        return trimExtraOptionDto;
    }
}
