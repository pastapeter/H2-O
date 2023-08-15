package com.h2o.h2oServer.domain.car.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CarMapper {
    Integer findMaximumModelTypePrice(Long id);

    Integer findMinimumModelTypePrice(Long id);
}
