package com.h2o.h2oServer.domain.model_type.mapper;

import com.h2o.h2oServer.domain.model_type.Entity.CarPowertrainEntity;
import com.h2o.h2oServer.domain.model_type.Entity.PowertrainEntity;
import com.h2o.h2oServer.domain.model_type.Entity.PowertrainOutputEntity;
import com.h2o.h2oServer.domain.model_type.Entity.PowertrainTorqueEntity;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Optional;

@Mapper
public interface PowertrainMapper {
    PowertrainEntity findById(Long id);

    Optional<PowertrainOutputEntity> findOutput(Long id);

    Optional<PowertrainTorqueEntity> findTorque(Long id);

    List<CarPowertrainEntity> findPowertrainsByCarId(Long carId);

    CarPowertrainEntity findDefaultPowertrainByCarId(Long carId);

    Boolean checkIfPowertrainExists(Long id);
}
