package com.h2o.h2oServer.domain.option.mapper;

import com.h2o.h2oServer.domain.option.entity.HashTagEntity;
import com.h2o.h2oServer.domain.option.entity.OptionDetailsEntity;
import com.h2o.h2oServer.domain.option.entity.enums.HashTag;
import com.h2o.h2oServer.domain.option.entity.enums.OptionCategory;
import org.assertj.core.api.SoftAssertions;
import org.junit.jupiter.api.DisplayName;
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
    private SoftAssertions softly = new SoftAssertions();

    @Test
    @DisplayName("존재하는 trim, option에 대해서 유효한 OptionEntity 객체를 반환한다.")
    @Sql("classpath:db/option/option-data.sql")
    void findOption() {
        //given
        Long trimId = 1L;
        Long optionId = 1L;
        OptionDetailsEntity expectedOptionDetailsEntity = OptionDetailsEntity.builder()
                .name("Option 1")
                .image("image_url_1")
                .description("Description for Option 1")
                .choiceRatio(0.3f)
                .useCount(12.5f)
                .category(OptionCategory.POWERTRAIN_PERFORMANCE)
                .price(500)
                .optionType("default")
                .build();

        //when
        OptionDetailsEntity actualOptionDetailsEntity = optionMapper.findOptionDetails(optionId, trimId);

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
        List<HashTagEntity> expectedHashTagEntities = List.of(
                HashTagEntity.builder()
                        .name(HashTag.CAMPING)
                        .build(),
                HashTagEntity.builder()
                        .name(HashTag.LEISURE)
                        .build(),
                HashTagEntity.builder()
                        .name(HashTag.SPORTS)
                        .build()
        );

        //when
        List<HashTagEntity> actualHashTagEntities = optionMapper.findHashTag(optionId);

        //then
        softly.assertThat(actualHashTagEntities).as("유효한 데이터가 매핑되었는지 확인").isNotEmpty();
        softly.assertThat(actualHashTagEntities).as("optionId에 해당하는 HashTagEntity 객체가 모두 매핑되었는지 확인")
                .contains(expectedHashTagEntities.get(0))
                .contains(expectedHashTagEntities.get(1))
                .contains(expectedHashTagEntities.get(2));
        softly.assertAll();
    }

    @Test
    @DisplayName("존재하는 옵션인 경우 true를 반환한다.")
    @Sql("classpath:db/option/option-data.sql")
    void checkIfOptionExists() {
        //given
        Long optionId = 1L;

        //when
        Boolean isExists = optionMapper.checkIfOptionExists(optionId);

        //then
        assertThat(isExists).isTrue();
    }

    @Test
    @DisplayName("존재하지 않는 옵션인 경우 false를 반환한다.")
    @Sql("classpath:db/option/option-data.sql")
    void checkIfOptionExistsFalse() {
        //given
        Long optionId = 5L;

        //when
        Boolean isExists = optionMapper.checkIfOptionExists(optionId);

        //then
        assertThat(isExists).isFalse();
    }
}
