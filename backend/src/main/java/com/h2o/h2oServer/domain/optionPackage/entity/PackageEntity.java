package com.h2o.h2oServer.domain.optionPackage.entity;

import com.h2o.h2oServer.domain.option.entity.enums.OptionCategory;
import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class PackageEntity {
    private String name;
    private OptionCategory category;
    private Integer price;
    private Float choiceRatio;
}
