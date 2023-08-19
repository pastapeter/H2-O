package com.h2o.h2oServer.domain.model_type.dto;

import io.swagger.annotations.ApiModel;
import lombok.Builder;
import lombok.Data;

@ApiModel(value = "유사 견적 정보 조회 응답 - 모델 타입 정보")
@Data
@Builder
public class ModelTypeNameDto {
    private String powertrainName;
    private String bodytypeName;
    private String drivetrainName;

    public static ModelTypeNameDto of(String powertrainName,
                                      String bodytypeName,
                                      String drivetrainName) {
        return ModelTypeNameDto.builder()
                .powertrainName(powertrainName)
                .bodytypeName(bodytypeName)
                .drivetrainName(drivetrainName)
                .build();
    }
}
