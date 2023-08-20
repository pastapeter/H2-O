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

        validateExistenceOfCarId(powertrainEntities);

        return powertrainEntities.stream()
                .map(this::mapToPowerTrainDto)
                .collect(Collectors.toList());
    }

    private CarPowertrainDto mapToPowerTrainDto(CarPowerTrainEntity powertrain) {
        Long powertrainId = powertrain.getPowertrainId();

        PowertrainOutputEntity output = powerTrainMapper.findOutput(powertrainId);

        if (output == null) {
            throw new NoSuchCarException();
        }

        PowertrainTorqueEntity torque = powerTrainMapper.findTorque(powertrainId);

        if (torque == null) {
            throw new NoSuchCarException();
        }

        return CarPowertrainDto.of(powertrain, output, torque);
    }

    private List<CarBodytypeDto> findBodytypes(Long carId) {
        List<CarBodytypeEntity> bodytypes = bodyTypeMapper.findBodytypesByCarId(carId);

        validateExistenceOfCarId(bodytypes);

        return CarBodytypeDto.listOf(bodytypes);
    }

    private List<CarDrivetrainDto> findDrivetrains(Long carId) {
        List<CarDrivetrainEntity> drivetrains = driveTrainMapper.findDrivetrainsByCarId(carId);

        validateExistenceOfCarId(drivetrains);

        return CarDrivetrainDto.listOf(drivetrains);
    }

    public TechnicalSpecDto findTechnicalSpec(Long powertrainId, Long drivetrainId) {
        TechnicalSpecEntity technicalSpecEntity = technicalSpecMapper.findSpec(powertrainId, drivetrainId);

        validateExistenceOfTechnicalSpec(technicalSpecEntity);

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

    private void validateExistenceOfCarId(List entities) {
        if (entities == null || entities.isEmpty()) {
            throw new NoSuchCarException();
        }
    }

    private void validateExistenceOfTechnicalSpec(TechnicalSpecEntity technicalSpecEntity) {
        if (technicalSpecEntity == null) {
            throw new NoSuchTechnicalSpecException();
        }
    }
}
