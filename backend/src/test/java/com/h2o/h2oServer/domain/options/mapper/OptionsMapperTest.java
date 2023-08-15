package com.h2o.h2oServer.domain.options.mapper;

import com.h2o.h2oServer.domain.option.entity.enums.OptionCategory;
import com.h2o.h2oServer.domain.options.entity.TrimDefaultOptionEntity;
import com.h2o.h2oServer.domain.options.entity.TrimExtraOptionEntity;
import org.assertj.core.api.SoftAssertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mybatis.spring.boot.test.autoconfigure.MybatisTest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.jdbc.Sql;

import java.util.List;

@MybatisTest
class OptionsMapperTest {

    private SoftAssertions softly;

    @Autowired
    private OptionsMapper optionsMapper;

    @BeforeEach
    void setUp() {
        softly = new SoftAssertions();
    }

    @Test
    @DisplayName("특정 트림에 추가 가능한 패키지를 조회하면 TrimExtraOptionEntity로 반환한다.")
    @Sql("classpath:db/options/package-data.sql")
    void findTrimPackages() {
        //given
        Long trimId = 1L;
        TrimExtraOptionEntity entity1 = TrimExtraOptionEntity.builder()
                .id(1L)
                .name("pack1")
                .image("img1")
                .category(OptionCategory.ACCESSORY)
                .price(1000)
                .choiceRatio(10.1f)
                .build();
        TrimExtraOptionEntity entity2 = TrimExtraOptionEntity.builder()
                .id(2L)
                .name("pack2")
                .image("img2")
                .category(OptionCategory.EXTERIOR)
                .price(2000)
                .choiceRatio(20.1f)
                .build();

        //when
        List<TrimExtraOptionEntity> packages = optionsMapper.findTrimPackages(trimId);

        //then
        softly.assertThat(packages).as("트림이 추가할 수 있는 패키지의 개수")
                .hasSize(2);
        softly.assertThat(packages).as("트림이 추가할 수 있는 패키지의 정보")
                .containsExactly(entity1, entity2);
        softly.assertAll();
    }

    @Test
    @DisplayName("특정 트림에 추가 가능한 옵션을 조회하면 TrimExtraOptionEntity로 반환한다.")
    @Sql("classpath:db/options/option-data.sql")
    void findTrimExtraOptions() {
        //given
        Long trimId = 1L;
        TrimExtraOptionEntity entity1 = TrimExtraOptionEntity.builder()
                .id(1L)
                .name("option1")
                .image("img1")
                .category(OptionCategory.ACCESSORY)
                .price(1000)
                .choiceRatio(21.2f)
                .build();
        TrimExtraOptionEntity entity2 = TrimExtraOptionEntity.builder()
                .id(4L)
                .name("option4")
                .image("img4")
                .category(OptionCategory.EXTERIOR)
                .price(2000)
                .choiceRatio(31.2f)
                .build();

        //when
        List<TrimExtraOptionEntity> options = optionsMapper.findTrimExtraOptions(trimId);

        //then
        softly.assertThat(options).as("트림이 추가할 수 있는 옵션의 개수")
                .hasSize(2);
        softly.assertThat(options).as("트림이 추가할 수 있는 옵션의 정보")
                .containsExactly(entity1, entity2);
        softly.assertAll();
    }

    @Test
    @DisplayName("특정 트림의 기본 옵션을 조회하면 TrimDefaultEntity로 반환한다.")
    @Sql("classpath:db/options/option-data.sql")
    void findTrimDefaultOptions() {
        //given
        Long trimId = 1L;
        TrimDefaultOptionEntity entity1 = TrimDefaultOptionEntity.builder()
                .id(2L)
                .name("option2")
                .image("img2")
                .category(OptionCategory.SAFETY)
                .choiceRatio(null)
                .useCount(20.0f)
                .build();
        TrimDefaultOptionEntity entity2 = TrimDefaultOptionEntity.builder()
                .id(3L)
                .name("option3")
                .image("img3")
                .category(OptionCategory.EXTERIOR)
                .choiceRatio(null)
                .useCount(20.0f)
                .build();

        //when
        List<TrimDefaultOptionEntity> options = optionsMapper.findTrimDefaultOptions(trimId);

        //then
        softly.assertThat(options).as("트림이 추가할 수 있는 옵션의 개수")
                .hasSize(2);
        softly.assertThat(options).as("트림이 추가할 수 있는 옵션의 정보")
                .containsExactly(entity1, entity2);
        softly.assertAll();
    }
}
