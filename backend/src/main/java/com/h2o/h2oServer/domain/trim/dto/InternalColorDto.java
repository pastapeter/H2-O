package com.h2o.h2oServer.domain.trim.dto;


import com.h2o.h2oServer.domain.trim.entity.InternalColorEntity;
import io.swagger.annotations.ApiModel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@ApiModel(value = "트림 내부 색상 정보 조회 응답")
@Builder
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class InternalColorDto {
    private Long id;
    private String name;
    private Integer choiceRatio;
    private Integer price;
    private String fabricImage;
    private String bannerImage;

    public static InternalColorDto of(InternalColorEntity internalColorEntity) {
        return InternalColorDto.builder()
                .id(internalColorEntity.getId())
                .name(internalColorEntity.getName())
                .choiceRatio(Math.round(internalColorEntity.getChoiceRatio() * 100))
                .price(internalColorEntity.getPrice())
                .fabricImage(internalColorEntity.getFabricImage())
                .bannerImage(internalColorEntity.getInternalImage())
                .build();
    }
}
