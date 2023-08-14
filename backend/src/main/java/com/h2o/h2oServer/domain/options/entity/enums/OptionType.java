package com.h2o.h2oServer.domain.options.entity.enums;

import lombok.Getter;

@Getter
public enum OptionType {
    DEFAULT("default"),
    EXTRA("extra");

    private final String label;

    OptionType(String label) {
        this.label = label;
    }
}
