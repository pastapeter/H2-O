package com.h2o.h2oServer.domain.option.entity;

import com.h2o.h2oServer.domain.option.entity.enums.OptionCategory;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;

@Getter
@Builder
@EqualsAndHashCode
public class TrimExtraOptionEntity {
    private Long id;
    private String name;
    private String image;
    private String pcImage;
    private String mobileImage;
    private OptionCategory category;
    private Float choiceRatio;
    private Integer price;
}
