package com.h2o.h2oServer.domain.trim.dto;

import com.h2o.h2oServer.domain.trim.entity.ImageEntity;
import lombok.Builder;
import lombok.Getter;

import java.awt.*;
import java.util.List;
import java.util.stream.Collectors;

@Getter
public class ImageDto {
    private List<String> images;

    private ImageDto(List<String> images) {
        this.images = images;
    }

    public static ImageDto of(List<ImageEntity> imageEntities) {
        List<String> images = imageEntities.stream()
                .map(ImageEntity::getImage)
                .collect(Collectors.toList());

        return new ImageDto(images);
    }
}
