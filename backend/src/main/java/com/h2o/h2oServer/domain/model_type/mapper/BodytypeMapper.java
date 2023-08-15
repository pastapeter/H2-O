package com.h2o.h2oServer.domain.model_type.mapper;

import com.h2o.h2oServer.domain.model_type.Entity.BodytypeEntity;
import com.h2o.h2oServer.domain.model_type.Entity.CarBodytypeEntity;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BodytypeMapper {
    BodytypeEntity findById(Long id);

    List<CarBodytypeEntity> findBodytypesByCarId(Long carId);

    CarBodytypeEntity findDefaultBodytypeByCarId(Long carId);
}
