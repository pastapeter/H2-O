package com.h2o.h2oServer.domain.option.entity;

import com.h2o.h2oServer.domain.option.entity.enums.OptionCategory;
import lombok.Builder;
import lombok.Data;

import java.io.Serializable;

@Data
@Builder
public class OptionDetailsEntity implements Serializable {
    private String name;
    private String image;
    private String pcImage;
    private String mobileImage;
    private String description;
    private OptionCategory category;
    private Float useCount;
    private Float choiceRatio;
    private Integer price;
    private String optionType;
}
