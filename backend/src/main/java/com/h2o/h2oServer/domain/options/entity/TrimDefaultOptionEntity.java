package com.h2o.h2oServer.domain.options.entity;

import com.h2o.h2oServer.domain.option.entity.enums.OptionCategory;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;

@Getter
@Builder
@EqualsAndHashCode
public class TrimDefaultOptionEntity {
    private Long id;
    private String name;
    private String image;
    private OptionCategory category;
    private Float choiceRatio;
    private Float useCount;
}
