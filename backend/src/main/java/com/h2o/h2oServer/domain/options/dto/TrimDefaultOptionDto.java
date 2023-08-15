package com.h2o.h2oServer.domain.options.dto;

import com.h2o.h2oServer.domain.option.entity.HashTagEntity;
import com.h2o.h2oServer.domain.options.entity.TrimDefaultOptionEntity;
import io.swagger.annotations.ApiModel;
import lombok.Data;

import java.util.List;
import java.util.stream.Collectors;

@ApiModel(value = "트림 기본 옵션 정보 조회 응답")
@Data
public class TrimDefaultOptionDto {
    private Long id;
    private String category;
    private String name;
    private String image;
    private List<String> hashTags;
    private boolean containsHmgData;

    private TrimDefaultOptionDto(Long id, String category, String name, String image, List<String> hashTags) {
        this.id = id;
        this.category = category;
        this.name = name;
        this.image = image;
        this.hashTags = hashTags;
    }

    public static TrimDefaultOptionDto of(TrimDefaultOptionEntity trimDefaultOptionEntity, List<HashTagEntity> hashTagEntities) {
        TrimDefaultOptionDto trimDefaultOptionDto = new TrimDefaultOptionDto(
                trimDefaultOptionEntity.getId(),
                trimDefaultOptionEntity.getCategory().getLabel(),
                trimDefaultOptionEntity.getName(),
                trimDefaultOptionEntity.getImage(),
                hashTagEntities.stream()
                        .map(hashTagEntity -> hashTagEntity.getName().getLabel())
                        .collect(Collectors.toList())
        );

        if (trimDefaultOptionEntity.getUseCount() != null || trimDefaultOptionEntity.getChoiceRatio() != null) {
            trimDefaultOptionDto.containsHmgData = true;
        }

        return trimDefaultOptionDto;
    }
}
