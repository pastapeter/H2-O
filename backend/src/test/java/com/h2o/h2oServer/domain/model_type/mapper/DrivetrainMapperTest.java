package com.h2o.h2oServer.domain.model_type.mapper;

import com.h2o.h2oServer.domain.model_type.Entity.CarDrivetrainEntity;
import com.h2o.h2oServer.domain.model_type.Entity.DrivetrainEntity;
import org.assertj.core.api.SoftAssertions;
import org.junit.jupiter.api.*;
import org.mybatis.spring.boot.test.autoconfigure.MybatisTest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.jdbc.Sql;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

@MybatisTest
@Sql("classpath:db/modelType/drivetrain-data.sql")
class DrivetrainMapperTest {

    @Autowired
    DrivetrainMapper drivetrainMapper;

    private SoftAssertions softly;

    @BeforeEach
    void setUp() {
        softly = new SoftAssertions();
    }

    @Test
    @DisplayName("존재하는 구동방식을 조회하면 해당 데이터를 DrivetrainEntity로 반환한다.")
    void findById() {
        //given
        Long drivetrainId = 1L;
        DrivetrainEntity drivetrain = DrivetrainEntity.builder()
                .id(1L)
                .name("name1")
                .description("description1")
                .image("img_url1")
                .build();

        //when
        DrivetrainEntity foundDrivetrain = drivetrainMapper.findById(drivetrainId);

        //then
        softly.assertThat(foundDrivetrain).as("유효한 데이터가 매핑되었는지 확인")
                .isEqualTo(drivetrain);
        softly.assertAll();
    }

    @Test
    @DisplayName("특정 차량의 구동방식을 조회하면 해당 차량에 적용 가능한 한 모든 구동방식을 CarDrivetrainEntity의 리스트로 반환한다.")
    void findDrivetrainsByCarId() {
        //given
        Long carId = 1L;
        CarDrivetrainEntity entity1 = CarDrivetrainEntity.builder()
                .carId(carId)
                .name("name1")
                .description("description1")
                .image("img_url1")
                .drivetrainId(1L)
                .price(10000)
                .choiceRatio(0.22f)
                .build();

        CarDrivetrainEntity entity2 = CarDrivetrainEntity.builder()
                .carId(carId)
                .name("name2")
                .description("description2")
                .image("img_url2")
                .drivetrainId(2L)
                .price(20000)
                .choiceRatio(0.23f)
                .build();

        //when
        List<CarDrivetrainEntity> foundEntities = drivetrainMapper.findDrivetrainsByCarId(carId);

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

    @Test
    @DisplayName("존재하는 구동방식인 경우 true를 반환한다.")
    void checkIfOptionExists() {
        //given
        Long drivetrainId = 1L;

        //when
        Boolean isExists = drivetrainMapper.checkIfDrivetrainExists(drivetrainId);

        //then
        assertThat(isExists).isTrue();
    }

    @Test
    @DisplayName("존재하지 않는 구동방식인 경우 false를 반환한다.")
    void checkIfOptionExistsFalse() {
        //given
        Long drivetrainId = 5L;

        //when
        Boolean isExists = drivetrainMapper.checkIfDrivetrainExists(drivetrainId);

        //then
        assertThat(isExists).isFalse();
    }
}
