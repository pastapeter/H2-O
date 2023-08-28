package com.h2o.h2oServer.domain.option.dto;

import com.h2o.h2oServer.domain.option.entity.HashTagEntity;
import com.h2o.h2oServer.domain.option.entity.TrimDefaultOptionEntity;
import io.swagger.annotations.ApiModel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@ApiModel(value = "트림 기본 옵션 정보 조회 응답")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class TrimDefaultOptionDto {
    private Long id;
    private String category;
    private String name;
    private String image;
    private String pcImage;
    private String mobileImage;
    private List<String> hashTags;
    private boolean containsHmgData;

    private TrimDefaultOptionDto(Long id, String category, String name, String image, String pcImage, String mobileImage, List<String> hashTags) {
        this.id = id;
        this.category = category;
        this.name = name;
        this.image = image;
        this.pcImage = pcImage;
        this.mobileImage = mobileImage;
        this.hashTags = hashTags;
    }

    public static TrimDefaultOptionDto of(TrimDefaultOptionEntity trimDefaultOptionEntity, List<HashTagEntity> hashTagEntities) {
        TrimDefaultOptionDto trimDefaultOptionDto = new TrimDefaultOptionDto(
                trimDefaultOptionEntity.getId(),
                trimDefaultOptionEntity.getCategory().getLabel(),
                trimDefaultOptionEntity.getName(),
                trimDefaultOptionEntity.getImage(),
                trimDefaultOptionEntity.getPcImage(),
                trimDefaultOptionEntity.getMobileImage(),
                hashTagEntities.stream()
                        .map(hashTagEntity -> hashTagEntity.getName().getLabel())
                        .collect(Collectors.toList())
        );

        Collections.sort(trimDefaultOptionDto.hashTags);

        if (trimDefaultOptionEntity.getUseCount() != null || trimDefaultOptionEntity.getChoiceRatio() != null) {
            trimDefaultOptionDto.containsHmgData = true;
        }

        return trimDefaultOptionDto;
    }
}
