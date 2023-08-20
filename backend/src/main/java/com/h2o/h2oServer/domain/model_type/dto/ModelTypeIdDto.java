package com.h2o.h2oServer.domain.model_type.dto;

import lombok.Builder;
import io.swagger.annotations.ApiModel;
import lombok.Data;

@ApiModel(value = "견적 저장 요청 - 모델 타입 id 정보")
@Data
@Builder
public class ModelTypeIdDto {
    private Long powertrainId;
    private Long bodytypeId;
    private Long drivetrainId;
}
