package com.h2o.h2oServer.domain.model_type.mapper;

import com.h2o.h2oServer.domain.model_type.Entity.CarDrivetrainEntity;
import com.h2o.h2oServer.domain.model_type.Entity.DrivetrainEntity;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface DrivetrainMapper {
    DrivetrainEntity findById(Long id);

    List<CarDrivetrainEntity> findDrivetrainsByCarId(Long carId);

    CarDrivetrainEntity findDefaultDrivetrainByCarId(Long carId);

    Boolean checkIfDrivetrainExists(Long id);
}
