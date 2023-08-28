package com.h2o.h2oServer.domain.option.dto;

import com.h2o.h2oServer.domain.option.entity.HashTagEntity;
import com.h2o.h2oServer.domain.option.entity.enums.HashTag;
import io.swagger.annotations.ApiModel;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@ApiModel(value = " 정보 조회 응답 - 바디 타입 정보")
@Data
public class HashTagDto implements Comparable<HashTagDto> {
    private HashTag name;

    private HashTagDto(HashTag name) {
        this.name = name;
    }

    public static HashTagDto of(HashTagEntity hashTagEntity) {
        return new HashTagDto(hashTagEntity.getName());
    }

    public static List<HashTagDto> listOf(List<HashTagEntity> hashTagEntities) {
        ArrayList<HashTagDto> hashTagDtos  = new ArrayList<>();

        for (HashTagEntity hashTagEntity : hashTagEntities) {
            hashTagDtos.add(of(hashTagEntity));
        }

        return hashTagDtos;
    }

    @Override
    public int compareTo(HashTagDto other) {
        return name.getLabel().compareTo(other.getName().getLabel());
    }
}
