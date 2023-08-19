package com.h2o.h2oServer.domain.quotation.entity;

import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.ToString;

@Getter
@Builder
@EqualsAndHashCode
@ToString
public class ReleaseEntity {
    private Long trimId;
    private Long powertrainId;
    private Long bodytypeId;
    private Long drivetrainId;
    private Long internalColorId;
    private Long externalColorId;
    private String optionCombination;
    private String packageCombination;
    private Integer price;
    private Integer quotationCount;
}
