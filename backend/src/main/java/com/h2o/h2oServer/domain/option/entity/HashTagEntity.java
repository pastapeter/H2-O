package com.h2o.h2oServer.domain.option.entity;

import com.h2o.h2oServer.domain.option.entity.enums.HashTag;
import lombok.Builder;
import lombok.Data;

import java.io.Serializable;

@Data
@Builder
public class HashTagEntity implements Serializable {
    private HashTag name;
}
