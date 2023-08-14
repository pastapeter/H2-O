package com.h2o.h2oServer.domain.model_type.mapper;

import com.h2o.h2oServer.domain.model_type.Entity.CarPowerTrainEntity;
import com.h2o.h2oServer.domain.model_type.Entity.PowertrainEntity;
import com.h2o.h2oServer.domain.model_type.Entity.PowertrainOutputEntity;
import com.h2o.h2oServer.domain.model_type.Entity.PowertrainTorqueEntity;
import org.assertj.core.api.SoftAssertions;
import org.junit.jupiter.api.*;
import org.mybatis.spring.boot.test.autoconfigure.MybatisTest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.jdbc.Sql;

import java.util.List;

@MybatisTest
@Sql("classpath:db/modelType/powertrain-data.sql")
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class PowertrainMapperTest {

    @Autowired
    PowertrainMapper powertrainMapper;

    private SoftAssertions softly;

    @BeforeEach
    void setUp() {
        softly = new SoftAssertions();
    }

    @Test
    @Order(4)
    @DisplayName("존재하는 파워트레인을 조회하면 해당 데이터를 PowertrainEntity로 반환한다.")
    void findById() {
        //given
        Long powertrainId = 1L;
        PowertrainEntity powertrain = PowertrainEntity.builder()
                .id(powertrainId)
                .name("powertrain1")
                .description("description1")
                .image("img_url1")
                .build();

        //when
        PowertrainEntity foundPowertrain = powertrainMapper.findById(powertrainId);

        //then
        softly.assertThat(foundPowertrain).as("유효한 데이터가 매핑되었는지 확인")
                .isEqualTo(powertrain);
    }

    @Test
    @Order(3)
    @DisplayName("특정 파워트레인의 최대출력을 조회하면 해당 데이터를 PowertrainOutputEntity로 반환한다.")
    void findOutput() {
        //given
        Long powertrainId = 1L;
        PowertrainOutputEntity output = PowertrainOutputEntity.builder()
                .powertrainId(powertrainId)
                .output(202.2f)
                .minRpm(1000)
                .maxRpm(1000)
                .build();

        //when
        PowertrainOutputEntity foundOutput = powertrainMapper.findOutput(powertrainId);

        //then
        softly.assertThat(foundOutput).as("유효한 데이터가 매핑되었는지 확인")
                .isEqualTo(output);
    }

    @Test
    @Order(2)
    @DisplayName("특정 파워트레인의 최대토크를 조회하면 해당 데이터를 PowertrainTorqueEntity로 반환한다.")
    void findTorque() {
        //given
        Long powertrainId = 1L;
        PowertrainTorqueEntity torque = PowertrainTorqueEntity.builder()
                .powertrainId(powertrainId)
                .torque(100.1f)
                .minRpm(3000)
                .maxRpm(3000)
                .build();

        //when
        PowertrainTorqueEntity foundTorque = powertrainMapper.findTorque(powertrainId);

        //then
        softly.assertThat(foundTorque).as("유효한 데이터가 매핑되었는지 확인")
                .isEqualTo(torque);
    }

    @Test
    @Order(1)
    @DisplayName("특정 차량의 파워트레인을 조회하면 해당 차량에 적용 가능한 모든 파워트레인을 CarPowertrainEntity의 리스트로 반환한다.")
    void findPowertrainsByCarId() {
        //given
        Long carId = 1L;
        CarPowerTrainEntity entity1 = CarPowerTrainEntity.builder()
                .carId(carId)
                .name("powertrain1")
                .description("description1")
                .image("img_url1")
                .powertrainId(1L)
                .price(100000)
                .choiceRatio(0.22f)
                .build();

        CarPowerTrainEntity entity2 = CarPowerTrainEntity.builder()
                .carId(carId)
                .name("powertrain2")
                .description("description2")
                .image("img_url2")
                .powertrainId(2L)
                .price(300000)
                .choiceRatio(0.21f)
                .build();

        //when
        List<CarPowerTrainEntity> foundEntities = powertrainMapper.findPowertrainsByCarId(carId);

        //then
        softly.assertThat(foundEntities).as("유효한 데이터가 매핑되었는지 확인")
                .isNotEmpty();
        softly.assertThat(foundEntities).as("유효한 데이터만 매핑되었는지 확인")
                .hasSize(2);
        softly.assertThat(foundEntities).as("carId에 해당하는 Entity가 모두 매핑되었는지 확인")
                .contains(entity1)
                .contains(entity2);

        softly.assertAll();
    }

}
