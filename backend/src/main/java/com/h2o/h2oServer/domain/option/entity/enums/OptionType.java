package com.h2o.h2oServer.domain.option.entity.enums;

import lombok.Getter;

@Getter
public enum OptionType {
    DEFAULT("default"),
    EXTRA("extra");

    public final String label;

    OptionType(String label) {
        this.label = label;
    }
}
