package com.h2o.h2oServer.domain.option.dto;

import com.h2o.h2oServer.domain.option.entity.OptionDetailsEntity;
import io.swagger.annotations.ApiModel;
import lombok.Builder;
import lombok.Data;

@ApiModel(value = "유사 견적 정보 조회 응답 - 옵션 정보")
@Data
@Builder
public class OptionSummaryDto {
    private Long id;
    private String name;
    private String category;
    private String image;
    private Integer price;

    public static OptionSummaryDto of(Long id, OptionDetailsEntity optionEntity) {
        return OptionSummaryDto.builder()
                .id(id)
                .name(optionEntity.getName())
                .image(optionEntity.getImage())
                .category(optionEntity.getCategory().getLabel())
                .price(optionEntity.getPrice())
                .build();
    }
}
