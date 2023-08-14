package com.h2o.h2oServer.domain.option.entity;

import com.h2o.h2oServer.domain.option.entity.enums.HashTag;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class HashTagEntity {
    private HashTag name;
}
