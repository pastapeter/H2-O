package com.h2o.h2oServer.domain.model_type.application;

import com.h2o.h2oServer.domain.car.exception.NoSuchCarException;
import com.h2o.h2oServer.domain.model_type.Entity.*;
import com.h2o.h2oServer.domain.model_type.TechnicalSpecFixture;
import com.h2o.h2oServer.domain.model_type.dto.*;
import com.h2o.h2oServer.domain.model_type.exception.NoSuchTechnicalSpecException;
import com.h2o.h2oServer.domain.model_type.mapper.BodytypeMapper;
import com.h2o.h2oServer.domain.model_type.mapper.DrivetrainMapper;
import com.h2o.h2oServer.domain.model_type.mapper.PowertrainMapper;
import com.h2o.h2oServer.domain.model_type.mapper.TechnicalSpecMapper;
import com.h2o.h2oServer.domain.trim.dto.DefaultTrimCompositionDto;
import org.assertj.core.api.SoftAssertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.Arguments;
import org.junit.jupiter.params.provider.MethodSource;
import org.mockito.Mockito;

import java.util.List;
import java.util.Optional;
import java.util.stream.Stream;

import static com.h2o.h2oServer.domain.model_type.DrivetrainFixture.*;
import static com.h2o.h2oServer.domain.model_type.PowertrainFixture.*;
import static com.h2o.h2oServer.domain.model_type.BodytypeFixture.*;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.Mockito.when;

class ModelTypeServiceTest {
    private ModelTypeService modelTypeService;
    private PowertrainMapper powertrainMapper;
    private BodytypeMapper bodytypeMapper;
    private DrivetrainMapper drivetrainMapper;
    private TechnicalSpecMapper technicalSpecMapper;
    private SoftAssertions softly;

    @BeforeEach
    void setup() {
        powertrainMapper = Mockito.mock(PowertrainMapper.class);
        bodytypeMapper = Mockito.mock(BodytypeMapper.class);
        drivetrainMapper = Mockito.mock(DrivetrainMapper.class);
        technicalSpecMapper = Mockito.mock(TechnicalSpecMapper.class);
        modelTypeService = new ModelTypeService(powertrainMapper,
                bodytypeMapper,
                drivetrainMapper,
                technicalSpecMapper);
        softly = new SoftAssertions();
    }

    @Test
    @DisplayName("존재하는 차량에 대해서 ModelTypeDto를 반환한다.")
    void findModelTypes() {
        //given
        Long carId = 1L;
        when(powertrainMapper.findPowertrainsByCarId(carId)).thenReturn(generateCarPowertrainEntities());
        when(powertrainMapper.findOutput(anyLong())).thenReturn(Optional.ofNullable(generatePowertrainOutputEntity()));
        when(powertrainMapper.findTorque(anyLong())).thenReturn(Optional.ofNullable(generatePowertrainTorqueEntity()));
        when(bodytypeMapper.findBodytypesByCarId(carId)).thenReturn(generateCarBodytypeEntities());
        when(drivetrainMapper.findDrivetrainsByCarId(carId)).thenReturn(generateCarDrivetrainEntities());

        //when
        ModelTypeDto modelTypeDto = modelTypeService.findModelTypes(carId);
        CarPowertrainDto carPowertrainDto = modelTypeDto.getPowertrains().get(0);
        CarBodytypeDto carBodytypeDto = modelTypeDto.getBodytypes().get(0);
        CarDrivetrainDto carDrivetrainDto = modelTypeDto.getDrivetrains().get(0);

        //then
        softly.assertThat(carPowertrainDto.getName()).as("파워트레인 이름은 powertrain1이다.").isEqualTo("powertrain1");
        softly.assertThat(carPowertrainDto.getImage()).as("파워트레인 이미지는 img_url1이다.").isEqualTo("img_url1");
        softly.assertThat(carBodytypeDto.getName()).as("바디타입 이름은 name1이다.").isEqualTo("name1");
        softly.assertThat(carBodytypeDto.getDescription()).as("바디타입 세부 설명은 description1이다.").isEqualTo("description1");
        softly.assertThat(carDrivetrainDto.getName()).as("구동방식 이름은 name 1이다.").isEqualTo("name1");
        softly.assertThat(carDrivetrainDto.getDescription()).as("구동방식 세부 설명은 description1이다.").isEqualTo("description1");
    }

    @ParameterizedTest
    @DisplayName("존재하지 않는 차량에 대해서 NoSuchCarException을 발생시킨다.")
    @MethodSource("provideInvalidResultsOfMappers")
    void findModelTypesNotExists(List<CarPowertrainEntity> carPowertrainEntities,
                                 PowertrainOutputEntity powertrainOutputEntity,
                                 PowertrainTorqueEntity powertrainTorqueEntity,
                                 List<CarBodytypeEntity> carBodytypeEntities,
                                 List<CarDrivetrainEntity> carDrivetrainEntities) {
        //given
        Long carId = 1L;
        when(powertrainMapper.findPowertrainsByCarId(carId)).thenReturn(carPowertrainEntities);
        when(powertrainMapper.findOutput(anyLong())).thenReturn(Optional.ofNullable(powertrainOutputEntity));
        when(powertrainMapper.findTorque(anyLong())).thenReturn(Optional.ofNullable(powertrainTorqueEntity));
        when(bodytypeMapper.findBodytypesByCarId(carId)).thenReturn(carBodytypeEntities);
        when(drivetrainMapper.findDrivetrainsByCarId(carId)).thenReturn(carDrivetrainEntities);

        //when
        //then
        assertThatThrownBy(() -> modelTypeService.findModelTypes(carId))
                .isInstanceOf(NoSuchCarException.class);
    }

    public static Stream<Arguments> provideInvalidResultsOfMappers() {
        return Stream.of(
                Arguments.of(
                        List.of(),
                        generatePowertrainOutputEntity(),
                        generatePowertrainTorqueEntity(),
                        generateCarBodytypeEntities(),
                        generateCarDrivetrainEntities()
                ),
                Arguments.of(
                        generateCarPowertrainEntities(),
                        null,
                        generatePowertrainTorqueEntity(),
                        generateCarBodytypeEntities(),
                        generateCarDrivetrainEntities()
                ),
                Arguments.of(
                        generateCarPowertrainEntities(),
                        generatePowertrainOutputEntity(),
                        null,
                        generateCarBodytypeEntities(),
                        generateCarDrivetrainEntities()
                ),
                Arguments.of(
                        generateCarPowertrainEntities(),
                        generatePowertrainOutputEntity(),
                        generatePowertrainTorqueEntity(),
                        List.of(),
                        generateCarDrivetrainEntities()
                ),
                Arguments.of(
                        generateCarPowertrainEntities(),
                        generatePowertrainOutputEntity(),
                        generatePowertrainTorqueEntity(),
                        generateCarBodytypeEntities(),
                        List.of()
                )
        );
    }

    @Nested
    @DisplayName("최대 출력 및 최대 토크 반환 테스트")
    class findTechnicalSpecTest {
        @Test
        @DisplayName("존재하는 powertrain과 drivetrain에 대한 요청일 경우 dto를 반환한다.")
        void findTechnicalSpec() {
            //given
            Long powertrainId = 1L;
            Long drivetrainId = 1L;
            TechnicalSpecDto expectedTechnicalSpecDto = TechnicalSpecFixture.generateTechnicalSpecDto();

            when(technicalSpecMapper.findSpec(powertrainId, drivetrainId))
                    .thenReturn(Optional.ofNullable(TechnicalSpecFixture.generateTechnicalSpecEntity()));

            //when
            TechnicalSpecDto actualTechnicalSpecDto = modelTypeService.findTechnicalSpec(powertrainId, drivetrainId);

            //then
            softly.assertThat(actualTechnicalSpecDto).as("null이 아니다.")
                    .isNotNull();
            softly.assertThat(actualTechnicalSpecDto).as("기대한 DTO로 반환된다.")
                    .isEqualTo(expectedTechnicalSpecDto);
            softly.assertAll();
        }

        @Test
        @DisplayName("존재하지 않는 powertrain 또는 drivetrain에 대한 요청일 경우 NoSuchTechnicalSpecException 반환한다.")
        void findTechnicalSpecNoPowertrain() {
            //given
            Long powertrainId = 1L;
            Long drivetrainId = 1L;

            when(technicalSpecMapper.findSpec(powertrainId, drivetrainId))
                    .thenReturn(Optional.empty());

            //when
            //then
            assertThatThrownBy(() -> modelTypeService.findTechnicalSpec(powertrainId, drivetrainId))
                    .isInstanceOf(NoSuchTechnicalSpecException.class);
        }
    }

    @Test
    @DisplayName("특정 차량 ID에 대해 drivetrain, bodytype, powertrain의 디폴트 값을 반환한다.")
    void findDefaultModelType() {
        //given
        Long carId = 1L;
        Long powertrainId = 1L;
        CarPowertrainEntity carPowertrainEntity = generateCarPowertrainEntities(carId).get(0);
        CarDrivetrainEntity carDrivetrainEntity = generateCarDrivetrainEntities(carId).get(0);
        CarBodytypeEntity carBodytypeEntity = generateCarBodyTypeEntities(carId).get(0);

        when(powertrainMapper.findOutput(powertrainId)).thenReturn(Optional.ofNullable(generatePowertrainOutputEntity(powertrainId)));
        when(powertrainMapper.findTorque(powertrainId)).thenReturn(Optional.ofNullable(generatePowertrainTorqueEntity(powertrainId)));
        when(drivetrainMapper.findDefaultDrivetrainByCarId(carId)).thenReturn(carDrivetrainEntity);
        when(bodytypeMapper.findDefaultBodytypeByCarId(carId)).thenReturn(carBodytypeEntity);
        when(powertrainMapper.findDefaultPowertrainByCarId(carId)).thenReturn(carPowertrainEntity);

        //when
        DefaultTrimCompositionDto defaultModelType = modelTypeService.findDefaultModelType(carId);

        //then
        softly.assertThat(defaultModelType.getPowertrain()).as("기본 파워트레인을 반환한다.")
                .isEqualTo(generateCarPowertrainDto());
        softly.assertThat(defaultModelType.getDrivetrain()).as("기본 구동타입을 반환한다.")
                .isEqualTo(generateCarDrivetrainDto());
        softly.assertThat(defaultModelType.getBodytype()).as("기본 바디타입을 반환한다.")
                .isEqualTo(generateCarBodytypeDto());
        softly.assertAll();
    }
}
