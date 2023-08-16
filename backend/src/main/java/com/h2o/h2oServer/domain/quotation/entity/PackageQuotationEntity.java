package com.h2o.h2oServer.domain.quotation.entity;

import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;

import java.util.List;

@Getter
@Builder
@EqualsAndHashCode
public class PackageQuotationEntity {
    private Long quotationId;
    private List<Long> packageIds;
}
