package com.h2o.h2oServer.domain.optionPackage;

import com.h2o.h2oServer.domain.option.entity.enums.OptionCategory;
import com.h2o.h2oServer.domain.optionPackage.entity.PackageEntity;

public class PackageFixture {
    public static PackageEntity generatePackageEntity() {
        return PackageEntity.builder()
                .name("Package 1")
                .category(OptionCategory.DETAILED_ITEM)
                .choiceRatio(0.7f)
                .price(500)
                .build();
    }
}
