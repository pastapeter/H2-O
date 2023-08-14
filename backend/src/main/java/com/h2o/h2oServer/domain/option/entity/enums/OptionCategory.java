package com.h2o.h2oServer.domain.option.entity.enums;

public enum OptionCategory {
    DETAILED_ITEM("상세품목"),
    ACCESSORY("악세사리"),
    WHEEL("휠"),
    POWERTRAIN_PERFORMANCE("파워트레인/성능"),
    INTELLIGENT_SAFETY_TECH("지능형 안전기술"),
    SAFETY("안전"),
    INTERIOR("내장"),
    EXTERIOR("외관"),
    SEATS("시트"),
    CONVENIENCE("편의"),
    MULTIMEDIA("멀티미디어");

    private final String label;

    OptionCategory(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }

    public static OptionCategory fromLabel(String label) {
        for (OptionCategory optionCategory : OptionCategory.values()) {
            if (optionCategory.getLabel().equals(label)) {
                return optionCategory;
            }
        }
        throw new IllegalArgumentException("존재하지 않는 옵션 라벨 : " + label);
    }
}
