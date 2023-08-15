package com.h2o.h2oServer.domain.model_type.mapper;

import com.h2o.h2oServer.domain.model_type.Entity.CarPowerTrainEntity;
import com.h2o.h2oServer.domain.model_type.Entity.PowertrainEntity;
import com.h2o.h2oServer.domain.model_type.Entity.PowertrainOutputEntity;
import com.h2o.h2oServer.domain.model_type.Entity.PowertrainTorqueEntity;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface PowertrainMapper {
    PowertrainEntity findById(Long id);
    PowertrainOutputEntity findOutput(Long id);
    PowertrainTorqueEntity findTorque(Long id);
    List<CarPowerTrainEntity> findPowertrainsByCarId(Long carId);
    CarPowerTrainEntity findDefaultPowertrainByCarId(Long carId);
}
