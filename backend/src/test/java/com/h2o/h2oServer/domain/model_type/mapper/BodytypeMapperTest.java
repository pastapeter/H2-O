package com.h2o.h2oServer.domain.model_type.mapper;

import com.h2o.h2oServer.domain.model_type.BodyTypeFixture;
import com.h2o.h2oServer.domain.model_type.Entity.BodytypeEntity;
import com.h2o.h2oServer.domain.model_type.Entity.CarBodytypeEntity;
import org.assertj.core.api.SoftAssertions;
import org.junit.jupiter.api.*;
import org.mybatis.spring.boot.test.autoconfigure.MybatisTest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.jdbc.Sql;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

@MybatisTest
@Sql("classpath:db/modelType/bodytype-data.sql")
class BodytypeMapperTest {

    @Autowired
    BodytypeMapper bodytypeMapper;

    private SoftAssertions softly;

    @BeforeEach
    void setUp() {
        softly = new SoftAssertions();
    }

    @Test
    @DisplayName("존재하는 바디타입을 조회하면 해당 데이터를 BodytypeEntity로 반환한다.")
    void findById() {
        //given
        Long bodytypeId = 1L;
        BodytypeEntity bodytype = BodyTypeFixture.generateBodytypeEntity();

        //when
        BodytypeEntity foundBodytype = bodytypeMapper.findById(bodytypeId);

        //then
        softly.assertThat(foundBodytype).as("유효한 데이터가 매핑되었는지 확인")
                .isEqualTo(bodytype);
        softly.assertAll();
    }

    @Test
    @DisplayName("특정 차량의 바디타입을 조회하면 해당 차량에 적용 가능한 한 모든 바디타입을 CarBodytypeEntity의 리스트로 반환한다.")
    void findBodytypeByCarId() {
        //given
        Long carId = 1L;
        List<CarBodytypeEntity> expectedCarBodytypeEntities = BodyTypeFixture.generateCarBodyTypeEntities();

        //when
        List<CarBodytypeEntity> foundEntities = bodytypeMapper.findBodytypesByCarId(carId);

        //then
        softly.assertThat(foundEntities).as("유효한 데이터가 매핑되었는지 확인")
                .isNotEmpty();
        softly.assertThat(foundEntities).as("유효한 데이터만 매핑되었는지 확인")
                .hasSize(2);
        softly.assertThat(foundEntities).as("carId에 해당하는 Entity가 모두 매핑되었는지 확인")
                .containsAll(expectedCarBodytypeEntities);
        softly.assertAll();
    }

    @Test
    @DisplayName("존재하는 바디타입인 경우 true를 반환한다.")
    void checkIfBodytypeExists() {
        //given
        Long id = 1L;

        //when
        Boolean isExists = bodytypeMapper.checkIfBodytypeExists(id);

        //then
        assertThat(isExists).isTrue();
    }

    @Test
    @DisplayName("존재하지 않는 바디타입인 경우 false를 반환한다.")
    void checkIfBodytypeExistsFalse() {
        //given
        Long id = 5L;

        //when
        Boolean isExists = bodytypeMapper.checkIfBodytypeExists(id);

        //then
        assertThat(isExists).isFalse();
    }
}
