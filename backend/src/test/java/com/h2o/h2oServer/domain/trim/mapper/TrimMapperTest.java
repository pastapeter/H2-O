package com.h2o.h2oServer.domain.trim.mapper;

import com.h2o.h2oServer.domain.trim.entity.TrimEntity;
import org.assertj.core.api.SoftAssertions;
import org.junit.jupiter.api.*;
import org.mybatis.spring.boot.test.autoconfigure.MybatisTest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.jdbc.Sql;

import java.util.List;

import static org.assertj.core.api.Assertions.*;

@MybatisTest
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
@Sql("classpath:db/trims-data.sql")
class TrimMapperTest {

    //todo : 예외 처리 테스트 추가

    @Autowired
    private TrimMapper trimMapper;

    private SoftAssertions softly;

    @BeforeEach
    void setup() {
        softly = new SoftAssertions();
    }

    @Test
    @DisplayName("존재하는 회원에 대해서, 해당하는 row를 Trim 객체에 담아 반환한다.")
    @Order(1)
    void findById() {
        //given
        Long targetId = 1L;
        TrimEntity expectedTrimEntity = TrimEntity.builder()
                .id(targetId)
                .name("Trim 1")
                .description("Basic Trim")
                .price(1500)
                .build();

        //when
        TrimEntity actualTrimEntity = trimMapper.findById(targetId);

        //then
        softly.assertThat(actualTrimEntity).as("유효한 데이터가 매핑되었는지 확인").isNotNull();
        softly.assertThat(actualTrimEntity).as("데이터베이스에 존재하는 데이터인지 확인").isEqualTo(expectedTrimEntity);
        softly.assertAll();
    }

    @Test
    @DisplayName("존재하지 않는 회원에 대해서는 null을 반환한다.")
    void findByIdWithoutResult() {
        //given
        Long targetId = Long.MAX_VALUE;

        //when
        TrimEntity actualTrimEntity = trimMapper.findById(targetId);

        //then
        assertThat(actualTrimEntity).isNull();
    }

    @Test
    @DisplayName("존재하는 회원에 대해서, 해당하는 row를 Trim 객체에 담아 반환한다.")
    @Order(2)
    void findByCarId() {
        //given
        Long targetCarId = 1L;
        TrimEntity expectedTrimEntity1 = TrimEntity.builder()
                .id(11L)
                .name("Trim 1")
                .description("Basic Trim")
                .price(1500)
                .build();
        TrimEntity expectedTrimEntity2 = TrimEntity.builder()
                .id(12L)
                .name("Trim 2")
                .description("Advanced Trim")
                .price(2500)
                .build();

        //when
        List<TrimEntity> actualTrimEntities = trimMapper.findByCarId(targetCarId);

        //then
        softly.assertThat(actualTrimEntities).as("유효한 데이터가 매핑되었는지 확인").isNotEmpty();
        softly.assertThat(actualTrimEntities).as("유효한 데이터만 매핑되었는지 확인").hasSize(2);
        softly.assertThat(actualTrimEntities).as("CarId에 해당하는 trim 객체가 모두 매핑되었는지 확인")
                .contains(expectedTrimEntity1)
                .contains(expectedTrimEntity2);
        softly.assertAll();
    }

    @Test
    @DisplayName("존재하지 않는 회원에 대해서는 null을 반환한다.")
    void findByCarIdWithoutResult() {
        //given
        Long targetCarId = Long.MAX_VALUE;

        //when
        List<TrimEntity> actualTrimEntities = trimMapper.findByCarId(targetCarId);

        //then
        assertThat(actualTrimEntities).isEmpty();
    }

    @Test
    @DisplayName("데이터베이스 상의 모든 row를 가져온다.")
    void findAll() {
        //given
        Long expectedLength = 10L;

        //when
        List<TrimEntity> actualTrimEntities = trimMapper.findAll();

        //then
        assertThat(actualTrimEntities).as("db에 존재하는 row의 개수와 길이가 같은지 확인").hasSize(Math.toIntExact(expectedLength));
    }
}
