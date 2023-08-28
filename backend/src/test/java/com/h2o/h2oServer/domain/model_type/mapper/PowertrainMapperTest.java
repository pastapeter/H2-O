package com.h2o.h2oServer.domain.model_type.mapper;

import com.h2o.h2oServer.domain.model_type.Entity.CarPowertrainEntity;
import com.h2o.h2oServer.domain.model_type.Entity.PowertrainEntity;
import com.h2o.h2oServer.domain.model_type.Entity.PowertrainOutputEntity;
import com.h2o.h2oServer.domain.model_type.Entity.PowertrainTorqueEntity;
import com.h2o.h2oServer.domain.model_type.PowertrainFixture;
import org.assertj.core.api.SoftAssertions;
import org.junit.jupiter.api.*;
import org.mybatis.spring.boot.test.autoconfigure.MybatisTest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.jdbc.Sql;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

@MybatisTest
@Sql("classpath:db/modelType/powertrain-data.sql")
class PowertrainMapperTest {

    @Autowired
    PowertrainMapper powertrainMapper;

    private SoftAssertions softly;

    @BeforeEach
    void setUp() {
        softly = new SoftAssertions();
    }

    @Test
    @DisplayName("존재하는 파워트레인을 조회하면 해당 데이터를 PowertrainEntity로 반환한다.")
    void findById() {
        //given
        Long powertrainId = 1L;
        PowertrainEntity powertrain = PowertrainFixture.generatePowertrainEntity(powertrainId);

        //when
        PowertrainEntity foundPowertrain = powertrainMapper.findById(powertrainId);

        //then
        softly.assertThat(foundPowertrain).as("유효한 데이터가 매핑되었는지 확인")
                .isEqualTo(powertrain);
    }

    @Test
    @DisplayName("특정 파워트레인의 최대출력을 조회하면 해당 데이터를 PowertrainOutputEntity로 반환한다.")
    void findOutput() {
        //given
        Long powertrainId = 1L;
        PowertrainOutputEntity output = PowertrainFixture.generatePowertrainOutputEntity(powertrainId);

        //when
        PowertrainOutputEntity foundOutput = powertrainMapper.findOutput(powertrainId).get();

        //then
        softly.assertThat(foundOutput).as("유효한 데이터가 매핑되었는지 확인")
                .isEqualTo(output);
    }

    @Test
    @DisplayName("특정 파워트레인의 최대토크를 조회하면 해당 데이터를 PowertrainTorqueEntity로 반환한다.")
    void findTorque() {
        //given
        Long powertrainId = 1L;
        PowertrainTorqueEntity torque = PowertrainFixture.generatePowertrainTorqueEntity(powertrainId);

        //when
        PowertrainTorqueEntity foundTorque = powertrainMapper.findTorque(powertrainId).get();

        //then
        softly.assertThat(foundTorque).as("유효한 데이터가 매핑되었는지 확인")
                .isEqualTo(torque);
    }

    @Test
    @DisplayName("특정 차량의 파워트레인을 조회하면 해당 차량에 적용 가능한 모든 파워트레인을 CarPowertrainEntity의 리스트로 반환한다.")
    void findPowertrainsByCarId() {
        //given
        Long carId = 1L;

        List<CarPowertrainEntity> expectedCarPowerTrainEntities = PowertrainFixture.generateCarPowertrainEntities(carId);

        //when
        List<CarPowertrainEntity> foundEntities = powertrainMapper.findPowertrainsByCarId(carId);

        //then
        softly.assertThat(foundEntities).as("유효한 데이터만 매핑되었는지 확인")
                .hasSize(2);
        softly.assertThat(foundEntities).as("carId에 해당하는 Entity가 모두 매핑되었는지 확인")
                .containsAll(expectedCarPowerTrainEntities);
        softly.assertAll();
    }

    @Test
    @DisplayName("존재하는 파워트레인인 경우 true를 반환한다.")
    void checkIfOptionExists() {
        //given
        Long id = 1L;

        //when
        boolean isExists = powertrainMapper.checkIfPowertrainExists(id);

        //then
        assertThat(isExists).isTrue();
    }

    @Test
    @DisplayName("존재하지 않는 바디타입인 경우 false를 반환한다.")
    void checkIfOptionExistsFalse() {
        //given
        Long id = 5L;

        //when
        boolean isExists = powertrainMapper.checkIfPowertrainExists(id);

        //then
        assertThat(isExists).isFalse();
    }
}
