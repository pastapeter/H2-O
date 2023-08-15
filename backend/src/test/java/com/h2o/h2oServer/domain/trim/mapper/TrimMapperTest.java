package com.h2o.h2oServer.domain.trim.mapper;

import com.h2o.h2oServer.domain.trim.entity.ExternalColorEntity;
import com.h2o.h2oServer.domain.trim.entity.InternalColorEntity;
import com.h2o.h2oServer.domain.trim.entity.TrimEntity;
import org.assertj.core.api.SoftAssertions;
import org.junit.jupiter.api.*;
import org.mybatis.spring.boot.test.autoconfigure.MybatisTest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.jdbc.Sql;

import java.util.List;

import static org.assertj.core.api.Assertions.*;

@MybatisTest
class TrimMapperTest {

    @Autowired
    private TrimMapper trimMapper;

    private SoftAssertions softly;

    @BeforeEach
    void setup() {
        softly = new SoftAssertions();
    }

    @Test
    @DisplayName("존재하는 회원에 대해서, 해당하는 row를 Trim 객체에 담아 반환한다.")
    @Sql("classpath:db/trim/trims-data.sql")
    void findById() {
        //given
        Long targetId = 1L;
        TrimEntity expectedTrimEntity = TrimEntity.builder()
                .id(targetId)
                .name("Trim 1")
                .description("Basic Trim")
                .price(1500)
                .carId(1L)
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
    @Sql("classpath:db/trim/trims-data.sql")
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
    @Sql("classpath:db/trim/trims-data.sql")
    void findByCarId() {
        //given
        Long targetCarId = 1L;
        TrimEntity expectedTrimEntity1 = TrimEntity.builder()
                .id(1L)
                .name("Trim 1")
                .description("Basic Trim")
                .price(1500)
                .carId(1L)
                .build();
        TrimEntity expectedTrimEntity2 = TrimEntity.builder()
                .id(2L)
                .name("Trim 2")
                .description("Advanced Trim")
                .price(2500)
                .carId(1L)
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
    @Sql("classpath:db/trim/trims-data.sql")
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
    @Sql("classpath:db/trim/trims-data.sql")
    void findAll() {
        //given
        Long expectedLength = 10L;

        //when
        List<TrimEntity> actualTrimEntities = trimMapper.findAll();

        //then
        assertThat(actualTrimEntities).as("db에 존재하는 row의 개수와 길이가 같은지 확인").hasSize(Math.toIntExact(expectedLength));
    }

    @Test
    @DisplayName("유효한 trim에 대해서, externalColorEntity를 반환한다.")
    @Sql("classpath:db/trim/external-color-data.sql")
    void findExternalColor() {
        //given
        Long trimId = 1L;
        ExternalColorEntity expectedExternalColorEntity1 = ExternalColorEntity.builder()
                .colorCode("#FF0000")
                .choiceRatio(0.3f)
                .id(1L)
                .name("Red")
                .price(2000)
                .build();
        ExternalColorEntity expectedExternalColorEntity2 = ExternalColorEntity.builder()
                .colorCode("#0000FF")
                .choiceRatio(0.5f)
                .id(2L)
                .name("Blue")
                .price(1800)
                .build();

        //when
        List<ExternalColorEntity> actualExternalColorEntities = trimMapper.findExternalColor(trimId);

        //then
        assertThat(actualExternalColorEntities).as("유효한 데이터가 매핑된다.").isNotEmpty();
        assertThat(actualExternalColorEntities).as("유효한 데이터가 매핑된다.").hasSize(2);
        softly.assertThat(actualExternalColorEntities).as("trimId에 해당하는 externalColorEntity 객체가 모두 매핑되었는지 확인")
                .contains(expectedExternalColorEntity1)
                .contains(expectedExternalColorEntity2);
        softly.assertAll();
    }

    @Test
    @DisplayName("존재하는 trimId에 대한 내부 색상 요청에 대해서 InternalColorEntity List를 반환한다. ")
    @Sql("classpath:db/trim/internal-color-data.sql")
    void findInternalColor() {
        //given
        Long trimId = 1L;
        InternalColorEntity expectEntity1 = InternalColorEntity.builder()
                .id(1L)
                .choiceRatio(0.3f)
                .price(2000)
                .fabricImage("fabric_image_url_1")
                .internalImage("internal_image_url_1")
                .name("Red")
                .build();
        InternalColorEntity expectEntity2 = InternalColorEntity.builder()
                .id(2L)
                .choiceRatio(0.2f)
                .price(1500)
                .fabricImage("fabric_image_url_2")
                .internalImage("internal_image_url_2")
                .name("Blue")
                .build();

        //when
        List<InternalColorEntity> actualEntities = trimMapper.findInternalColor(trimId);

        //then
        softly.assertThat(actualEntities).as("유효한 데이터가 매핑되었는지 확인").isNotEmpty();
        softly.assertThat(actualEntities).as("유효한 데이터만 매핑되었는지 확인").hasSize(2);
        softly.assertThat(actualEntities).as("trimId에 해당하는 InternalColorEntity 객체가 모두 매핑되었는지 확인")
                .contains(expectEntity1)
                .contains(expectEntity2);
        softly.assertAll();
    }

    @Test
    @DisplayName("트림이 가질 수 있는 패키지/추가 옵션 가격의 합을 반환한다.")
    @Sql("classpath:db/trim/trims-option-data.sql")
    void findMaximumComponentPrice() {
        //given
        Long trimId = 1L;
        Integer expectedPrice = 4890;

        //when
        Integer actualPrice = trimMapper.findMaximumComponentPrice(trimId);

        //then
        assertThat(actualPrice).isEqualTo(expectedPrice);
    }
}
