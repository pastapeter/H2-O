package com.h2o.h2oServer.domain.trim.mapper;

import com.h2o.h2oServer.domain.trim.ExternalColorFixture;
import com.h2o.h2oServer.domain.trim.InternalColorFixture;
import com.h2o.h2oServer.domain.trim.TrimFixture;
import com.h2o.h2oServer.domain.trim.entity.ExternalColorEntity;
import com.h2o.h2oServer.domain.trim.entity.InternalColorEntity;
import com.h2o.h2oServer.domain.trim.entity.TrimEntity;
import org.assertj.core.api.SoftAssertions;
import org.junit.jupiter.api.*;
import org.mybatis.spring.boot.test.autoconfigure.MybatisTest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.jdbc.Sql;

import java.util.List;
import java.util.Optional;

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

    @Nested
    @DisplayName("트림 검색 테스트")
    @Sql("classpath:db/trim/trims-data.sql")
    class FindTest {
        @Test
        @DisplayName("존재하는 회원에 대해서, 해당하는 row를 Trim 객체에 담아 반환한다.")
        void findById() {
            //given
            Long targetId = 1L;
            TrimEntity expectedTrimEntity = TrimFixture.generateTrimEntity();

            //when
            TrimEntity actualTrimEntity = trimMapper.findById(targetId).get();

            //then
            softly.assertThat(actualTrimEntity).as("데이터베이스에 존재하는 데이터인지 확인").isEqualTo(expectedTrimEntity);
            softly.assertAll();
        }

        @Test
        @DisplayName("존재하지 않는 트림에 대해서는 null을 반환한다.")
        void findByIdWithoutResult() {
            //given
            Long targetId = Long.MAX_VALUE;

            //when
            Optional<TrimEntity> actualTrimEntity = trimMapper.findById(targetId);

            //then
            assertThat(actualTrimEntity).isEmpty();
        }

        @Test
        @DisplayName("존재하는 회원에 대해서, 해당하는 row를 Trim 객체에 담아 반환한다.")
        void findByCarId() {
            //given
            Long targetCarId = 1L;
            List<TrimEntity> expectedTrimEntities = TrimFixture.generateTrimEntityList();

            //when
            List<TrimEntity> actualTrimEntities = trimMapper.findByCarId(targetCarId);

            //then
            softly.assertThat(actualTrimEntities).as("유효한 데이터만 매핑되었는지 확인").hasSize(2);
            softly.assertThat(actualTrimEntities).as("CarId에 해당하는 trim 객체가 모두 매핑되었는지 확인")
                    .containsAll(expectedTrimEntities);
            softly.assertAll();
        }

        @Test
        @DisplayName("존재하지 않는 차량에 대해서는 빈 배열을 반환한다.")
        void findByCarIdWithoutResult() {
            //given
            Long targetCarId = Long.MAX_VALUE;

            //when
            List<TrimEntity> actualTrimEntities = trimMapper.findByCarId(targetCarId);

            //then
            assertThat(actualTrimEntities).isEmpty();
        }
    }

    @Nested
    @DisplayName("색상 조회 테스트")
    class FindColorTest {
        @Test
        @DisplayName("존재하는 trim에 대한 외부 색상 요청일 경우 externalColorEntity를 반환한다.")
        @Sql("classpath:db/trim/external-color-data.sql")
        void findExternalColor() {
            //given
            Long trimId = 1L;
            List<ExternalColorEntity> expectedExternalColorEntities = ExternalColorFixture.generateExternalColorEntityList();

            //when
            List<ExternalColorEntity> actualExternalColorEntities = trimMapper.findExternalColor(trimId);

            //then
            assertThat(actualExternalColorEntities).as("유효한 데이터가 매핑된다.").isNotEmpty();
            assertThat(actualExternalColorEntities).as("유효한 데이터가 매핑된다.").hasSize(2);
            softly.assertThat(actualExternalColorEntities).as("trimId에 해당하는 externalColorEntity 객체가 모두 매핑되었는지 확인")
                    .containsAll(expectedExternalColorEntities);
            softly.assertAll();
        }

        @Test
        @DisplayName("존재하지 않는 trim에 대해서는 빈 배열을 반환한다.")
        @Sql("classpath:db/trim/external-color-data.sql")
        void findExternalColorNotExists() {
            //given
            Long trimId = Long.MAX_VALUE;

            //when
            List<ExternalColorEntity> actualExternalColorEntity = trimMapper.findExternalColor(trimId);

            //then
            assertThat(actualExternalColorEntity).isEmpty();
        }

        @Test
        @DisplayName("존재하는 trim에 대한 내부 색상 요청일 경우 InternalColorEntity를 반환한다. ")
        @Sql("classpath:db/trim/internal-color-data.sql")
        void findInternalColor() {
            //given
            Long trimId = 1L;
            List<InternalColorEntity> expectedInternalColorEntities = InternalColorFixture.generateInernalColorEntityList();

            //when
            List<InternalColorEntity> actualEntities = trimMapper.findInternalColor(trimId);

            //then
            softly.assertThat(actualEntities).as("유효한 데이터가 매핑되었는지 확인").isNotEmpty();
            softly.assertThat(actualEntities).as("유효한 데이터만 매핑되었는지 확인").hasSize(2);
            softly.assertThat(actualEntities).as("trimId에 해당하는 InternalColorEntity 객체가 모두 매핑되었는지 확인")
                    .containsAll(expectedInternalColorEntities);
            softly.assertAll();
        }

        @Test
        @DisplayName("존재하지 않는 trim에 대해서는 빈 배열을 반환한다.")
        @Sql("classpath:db/trim/internal-color-data.sql")
        void findInternalColorNotExists() {
            //given
            Long trimId = Long.MAX_VALUE;

            //when
            List<InternalColorEntity> actualInternalColorEntity = trimMapper.findInternalColor(trimId);

            //then
            assertThat(actualInternalColorEntity).isEmpty();
        }
    }

    @Test
    @DisplayName("데이터베이스 상의 모든 row를 가져온다.")
    @Sql("classpath:db/trim/trims-data.sql")
    void findAll() {
        //given
        long expectedLength = 10L;

        //when
        List<TrimEntity> actualTrimEntities = trimMapper.findAll();

        //then
        assertThat(actualTrimEntities).as("db에 존재하는 row의 개수와 길이가 같은지 확인").hasSize(Math.toIntExact(expectedLength));
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

    @Nested
    @DisplayName("존재 여부 확인 쿼리 테스트")
    class checkIfTrimExistTest {
        @Test
        @DisplayName("존재하는 트림인 경우 true를 반환한다.")
        @Sql("classpath:db/trim/trims-data.sql")
        void checkIfTrimExists() {
            //given
            Long id = 1L;

            //when
            boolean isExists = trimMapper.checkIfTrimExists(id);

            //then
            assertThat(isExists).isTrue();
        }

        @Test
        @DisplayName("존재하지 않는 트림인 경우 false를 반환한다.")
        @Sql("classpath:db/trim/trims-data.sql")
        void checkIfTrimExistsFalse() {
            //given
            Long id = 11L;

            //when
            boolean isExists = trimMapper.checkIfTrimExists(id);

            //then
            assertThat(isExists).isFalse();
        }
    }

    @Test
    @DisplayName("가격 범위 내의 출고 개수만을 반환한다.")
    @Sql("classpath:db/trim/sold-car-data.sql")
    void findQuantityBetween() {
        //given
        Long trimId = 1L;
        int from = 30000;
        int to = 70000;
        int expectedResult = 9;

        //when
        Integer actualResult = trimMapper.findQuantityBetween(trimId, from, to);

        //then
        assertThat(actualResult).isEqualTo(expectedResult);
    }
}
