package com.h2o.h2oServer.domain.model_type.application;

import com.h2o.h2oServer.domain.model_type.Entity.*;
import com.h2o.h2oServer.domain.model_type.dto.*;
import com.h2o.h2oServer.domain.model_type.mapper.BodytypeMapper;
import com.h2o.h2oServer.domain.model_type.mapper.DrivetrainMapper;
import com.h2o.h2oServer.domain.model_type.mapper.PowertrainMapper;
import com.h2o.h2oServer.domain.model_type.mapper.TechnicalSpecMapper;
import com.h2o.h2oServer.domain.trim.dto.DefaultTrimCompositionDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

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

    private List<CarPowertrainDto> findPowertrains(Long carId) {
        List<CarPowerTrainEntity> powertrainEntities = powerTrainMapper.findPowertrainsByCarId(carId);

        return powertrainEntities.stream()
                .map(this::mapToPowerTrainDto)
                .collect(Collectors.toList());
    }

    private CarPowertrainDto mapToPowerTrainDto(CarPowerTrainEntity powertrain) {
        Long powertrainId = powertrain.getPowertrainId();

        PowertrainOutputEntity output = powerTrainMapper.findOutput(powertrainId);
        PowertrainTorqueEntity torque = powerTrainMapper.findTorque(powertrainId);

        return CarPowertrainDto.of(powertrain, output, torque);
    }

    private List<CarBodytypeDto> findBodytypes(Long carId) {
        List<CarBodytypeEntity> bodytypes = bodyTypeMapper.findBodytypesByCarId(carId);
        return CarBodytypeDto.listOf(bodytypes);
    }

    private List<CarDrivetrainDto> findDrivetrains(Long carId) {
        List<CarDrivetrainEntity> drivetrains = driveTrainMapper.findDrivetrainsByCarId(carId);
        return CarDrivetrainDto.listOf(drivetrains);
    }

    public TechnicalSpecDto findTechnicalSpec(Long powertrainId, Long drivetrainId) {
        TechnicalSpecEntity technicalSpecEntity = technicalSpecMapper.findSpec(powertrainId, drivetrainId);
        // TODO: null 체크 후 Exception 발생
        return TechnicalSpecDto.of(technicalSpecEntity);
    }

    public DefaultTrimCompositionDto findDefaultModelType(Long carId) {
        CarDrivetrainDto carDrivetrainDto = CarDrivetrainDto.of(driveTrainMapper.findDefaultDrivetrainByCarId(carId));
        CarBodytypeDto carBodytypeDto = CarBodytypeDto.of(bodyTypeMapper.findDefaultBodytypeByCarId(carId));
        CarPowertrainDto carPowertrainDto = mapToPowerTrainDto(powerTrainMapper.findDefaultPowertrainByCarId(carId));

        return DefaultTrimCompositionDto.builder()
                .bodytype(carBodytypeDto)
                .drivetrain(carDrivetrainDto)
                .powertrain(carPowertrainDto)
                .build();
    }
}
