package com.h2o.h2oServer.domain.model_type.application;

import com.h2o.h2oServer.domain.car.exception.NoSuchCarException;
import com.h2o.h2oServer.domain.model_type.Entity.*;
import com.h2o.h2oServer.domain.model_type.dto.*;
import com.h2o.h2oServer.domain.model_type.exception.NoSuchTechnicalSpecException;
import com.h2o.h2oServer.domain.model_type.mapper.BodytypeMapper;
import com.h2o.h2oServer.domain.model_type.mapper.DrivetrainMapper;
import com.h2o.h2oServer.domain.model_type.mapper.PowertrainMapper;
import com.h2o.h2oServer.domain.model_type.mapper.TechnicalSpecMapper;
import com.h2o.h2oServer.domain.trim.dto.DefaultTrimCompositionDto;
import com.h2o.h2oServer.global.util.Validator;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ModelTypeService {
    private final PowertrainMapper powertrainMapper;
    private final BodytypeMapper bodytypeMapper;
    private final DrivetrainMapper drivetrainMapper;
    private final TechnicalSpecMapper technicalSpecMapper;

    public ModelTypeDto findModelTypes(Long carId) {
        return ModelTypeDto.of(findPowertrains(carId), findBodytypes(carId), findDrivetrains(carId));
    }

    private List<CarPowertrainDto> findPowertrains(Long carId) {
        List<CarPowertrainEntity> powertrains = powertrainMapper.findPowertrainsByCarId(carId);

        Validator.validateExistenceOfCarId(powertrains);

        return powertrains.stream()
                .map(this::mapToPowerTrainDto)
                .collect(Collectors.toList());
    }

    private CarPowertrainDto mapToPowerTrainDto(CarPowertrainEntity powertrain) {
        Long powertrainId = powertrain.getPowertrainId();

        PowertrainOutputEntity output = powertrainMapper.findOutput(powertrainId)
                .orElseThrow(NoSuchCarException::new);

        PowertrainTorqueEntity torque = powertrainMapper.findTorque(powertrainId)
                .orElseThrow(NoSuchCarException::new);

        return CarPowertrainDto.of(powertrain, output, torque);
    }

    private List<CarBodytypeDto> findBodytypes(Long carId) {
        List<CarBodytypeEntity> bodytypes = bodytypeMapper.findBodytypesByCarId(carId);

        Validator.validateExistenceOfCarId(bodytypes);

        return CarBodytypeDto.listOf(bodytypes);
    }

    private List<CarDrivetrainDto> findDrivetrains(Long carId) {
        List<CarDrivetrainEntity> drivetrains = drivetrainMapper.findDrivetrainsByCarId(carId);

        Validator.validateExistenceOfCarId(drivetrains);

        return CarDrivetrainDto.listOf(drivetrains);
    }

    public TechnicalSpecDto findTechnicalSpec(Long powertrainId, Long drivetrainId) {
        TechnicalSpecEntity technicalSpec = technicalSpecMapper.findSpec(powertrainId, drivetrainId)
                .orElseThrow(NoSuchTechnicalSpecException::new);

        return TechnicalSpecDto.of(technicalSpec);
    }

    public DefaultTrimCompositionDto findDefaultModelType(Long carId) {
        CarDrivetrainDto carDrivetrainDto = CarDrivetrainDto.of(drivetrainMapper.findDefaultDrivetrainByCarId(carId));
        CarBodytypeDto carBodytypeDto = CarBodytypeDto.of(bodytypeMapper.findDefaultBodytypeByCarId(carId));
        CarPowertrainDto carPowertrainDto = mapToPowerTrainDto(powertrainMapper.findDefaultPowertrainByCarId(carId));

        return DefaultTrimCompositionDto.builder()
                .bodytype(carBodytypeDto)
                .drivetrain(carDrivetrainDto)
                .powertrain(carPowertrainDto)
                .build();
    }
}
