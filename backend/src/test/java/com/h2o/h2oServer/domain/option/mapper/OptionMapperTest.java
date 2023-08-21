package com.h2o.h2oServer.domain.option.mapper;

import com.h2o.h2oServer.domain.option.HashTagFixture;
import com.h2o.h2oServer.domain.option.OptionFixture;
import com.h2o.h2oServer.domain.option.entity.HashTagEntity;
import com.h2o.h2oServer.domain.option.entity.OptionDetailsEntity;
import org.assertj.core.api.SoftAssertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.mybatis.spring.boot.test.autoconfigure.MybatisTest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.jdbc.Sql;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

@MybatisTest
class OptionMapperTest {

    @Autowired
    private OptionMapper optionMapper;
    private final SoftAssertions softly = new SoftAssertions();

    @Test
    @DisplayName("존재하는 trim, option에 대해서 유효한 OptionEntity 객체를 반환한다.")
    @Sql("classpath:db/option/option-data.sql")
    void findOption() {
        //given
        Long trimId = 1L;
        Long optionId = 1L;
        OptionDetailsEntity expectedOptionDetailsEntity = OptionFixture.generateOptionDetailsEntity();

        //when
        OptionDetailsEntity actualOptionDetailsEntity = optionMapper.findOptionDetails(optionId, trimId).get();

        //then
        softly.assertThat(actualOptionDetailsEntity).as("유효한 데이터가 매핑되었는지 확인").isNotNull();
        softly.assertThat(actualOptionDetailsEntity).as("데이터베이스에 존재하는 데이터인지 확인").isEqualTo(expectedOptionDetailsEntity);
        softly.assertAll();
    }

    @Test
    @DisplayName("존재하는 option에 대해서 유효한 HashTagEntity 객체를 반환한다.")
    @Sql("classpath:db/option/hashtag-data.sql")
    void findHashTag() {
        //given
        Long optionId = 1L;
        List<HashTagEntity> expectedHashTagEntities = HashTagFixture.generateHashTagEntities();

        //when
        List<HashTagEntity> actualHashTagEntities = optionMapper.findHashTag(optionId);

        //then
        assertThat(actualHashTagEntities).as("optionId에 해당하는 HashTagEntity 객체가 모두 매핑되었는지 확인")
                .containsAll(expectedHashTagEntities);
    }

    @Nested
    @DisplayName("존재 여부 확인 쿼리 테스트")
    @Sql("classpath:db/option/option-data.sql")
    class CheckIfOptionExists {
        @Test
        @DisplayName("존재하는 옵션인 경우 true를 반환한다.")
        void checkIfOptionExists() {
            //given
            Long optionId = 1L;

            //when
            boolean isExists = optionMapper.checkIfOptionExists(optionId);

            //then
            assertThat(isExists).isTrue();
        }

        @Test
        @DisplayName("존재하지 않는 옵션인 경우 false를 반환한다.")
        void checkIfOptionExistsFalse() {
            //given
            Long optionId = 5L;

            //when
            boolean isExists = optionMapper.checkIfOptionExists(optionId);

            //then
            assertThat(isExists).isFalse();
        }
    }
}
