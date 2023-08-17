package com.h2o.h2oServer.domain.model_type.mapper;

import com.h2o.h2oServer.domain.model_type.Entity.TechnicalSpecEntity;
import org.assertj.core.api.SoftAssertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mybatis.spring.boot.test.autoconfigure.MybatisTest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.jdbc.Sql;

import static org.assertj.core.api.Assertions.assertThat;

@MybatisTest
@Sql("classpath:db/modelType/technical-spec-data.sql")
class TechnicalSpecMapperTest {

    @Autowired
    private TechnicalSpecMapper technicalSpecMapper;

    private SoftAssertions softly;

    @BeforeEach
    void setUp() {
        softly = new SoftAssertions();
    }

    @Test
    @DisplayName("특정 파워트레인과 구동방식의 조합으로 조회하면 배기량과 평균 연비를 알 수 있다.")
    void findSpec() {
        //given
        Long powertrainId = 1L;
        Long drivetrainId = 1L;

        TechnicalSpecEntity expectedEntity = TechnicalSpecEntity.builder()
                .powertrainId(powertrainId)
                .drivetrainId(drivetrainId)
                .displacement(10)
                .fuelEfficiency(10.1f)
                .build();

        //when
        TechnicalSpecEntity actualEntity = technicalSpecMapper.findSpec(powertrainId, drivetrainId);

        //then
        softly.assertThat(actualEntity.getDisplacement()).as("배기량을 알 수 있다.")
                .isEqualTo(expectedEntity.getDisplacement());
        softly.assertThat(actualEntity.getFuelEfficiency()).as("평균 연비를 알 수 있다.")
                .isEqualTo(expectedEntity.getFuelEfficiency());
        softly.assertAll();
    }

    @Test
    @DisplayName("존재하지 않는 파워트레인과 구동방식의 조합으로 조회하면 null이 반환된다.")
    void shouldReturnNull() {
        //given
        Long notExistPowertrainId = 10L;
        Long notExistDrivetrainId = 20L;

        //when
        TechnicalSpecEntity actualEntity = technicalSpecMapper.findSpec(
                notExistPowertrainId,
                notExistDrivetrainId
        );

        //then
        softly.assertThat(actualEntity).as("null이 반환된다.")
                .isNull();
    }

    @Test
    @DisplayName("존재하는 성능 정보인 경우 true를 반환한다.")
    void checkIfOptionExists() {
        //given
        Long powertrainId = 1L;
        Long drivetrainId = 1L;

        //when
        Boolean isExists = technicalSpecMapper.checkIfTechnicalSpecExists(powertrainId, drivetrainId);

        //then
        assertThat(isExists).isTrue();
    }

    @Test
    @DisplayName("존재하지 않는 성능 정보인 경우 false를 반환한다.")
    void checkIfOptionExistsFalse() {
        //given
        Long powertrainId = 110L;
        Long drivetrainId = 10L;
        //when
        Boolean isExists = technicalSpecMapper.checkIfTechnicalSpecExists(powertrainId, drivetrainId);

        //then
        assertThat(isExists).isFalse();
    }
}
