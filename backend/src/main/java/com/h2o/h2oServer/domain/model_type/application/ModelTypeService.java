package com.h2o.h2oServer.domain.model_type.application;

import com.h2o.h2oServer.domain.model_type.Entity.*;
import com.h2o.h2oServer.domain.model_type.dto.*;
import com.h2o.h2oServer.domain.model_type.mapper.BodytypeMapper;
import com.h2o.h2oServer.domain.model_type.mapper.DrivetrainMapper;
import com.h2o.h2oServer.domain.model_type.mapper.PowertrainMapper;
import com.h2o.h2oServer.domain.model_type.mapper.TechnicalSpecMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ModelTypeService {

    private final PowertrainMapper powerTrainMapper;
    private final BodytypeMapper bodyTypeMapper;
    private final DrivetrainMapper driveTrainMapper;
    private final TechnicalSpecMapper technicalSpecMapper;

    public ModelTypeDto findModelTypes(Long carId) {
        return ModelTypeDto.of(findPowertrains(carId), findBodytypes(carId), findDrivetrains(carId));
    }

    public List<CarPowertrainDto> findPowertrains(Long carId) {
        List<CarPowertrainDto> detailPowertrains = new ArrayList<>();

        List<CarPowerTrainEntity> powertrains = powerTrainMapper.findPowertrainsByCarId(carId);

        for (CarPowerTrainEntity powertrain : powertrains) {
            Long powertrainId = powertrain.getPowertrainId();

            PowertrainOutputEntity output = powerTrainMapper.findOutput(powertrainId);
            PowertrainTorqueEntity torque = powerTrainMapper.findTorque(powertrainId);

            detailPowertrains.add(CarPowertrainDto.of(powertrain, output, torque));
        }

        return detailPowertrains;
    }

    public List<CarBodytypeDto> findBodytypes(Long carId) {
        List<CarBodytypeEntity> bodytypes = bodyTypeMapper.findBodytypesByCarId(carId);
        return CarBodytypeDto.listOf(bodytypes);
    }

    public List<CarDrivetrainDto> findDrivetrains(Long carId) {
        List<CarDrivetrainEntity> drivetrains = driveTrainMapper.findDrivetrainsByCarId(carId);
        return CarDrivetrainDto.listOf(drivetrains);
    }

    public TechnicalSpecDto findTechnicalSpec(Long powertrainId, Long drivetrainId) {
        TechnicalSpecEntity technicalSpecEntity = technicalSpecMapper.findSpec(powertrainId, drivetrainId);
        // TODO: null 체크 후 Exception 발생
        return TechnicalSpecDto.of(technicalSpecEntity);
    }
}
