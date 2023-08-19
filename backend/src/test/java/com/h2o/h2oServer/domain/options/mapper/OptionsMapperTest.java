package com.h2o.h2oServer.domain.options.mapper;

import com.h2o.h2oServer.domain.option.entity.enums.OptionCategory;
import com.h2o.h2oServer.domain.options.dto.PageRangeDto;
import com.h2o.h2oServer.domain.options.entity.TrimDefaultOptionEntity;
import com.h2o.h2oServer.domain.options.entity.TrimExtraOptionEntity;
import com.h2o.h2oServer.domain.options.enums.OptionType;
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
        TrimExtraOptionEntity entity1 = createTrimExtraOptionEntity(
                1L, "pack1", "img1", OptionCategory.ACCESSORY, 1000, 10.1f
        );
        TrimExtraOptionEntity entity2 = createTrimExtraOptionEntity(
                2L, "pack2", "img2", OptionCategory.EXTERIOR, 2000, 20.1f
        );

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
        TrimExtraOptionEntity entity1 = createTrimExtraOptionEntity(
                1L, "option1", "img1", OptionCategory.ACCESSORY, 1000, 21.2f
        );
        TrimExtraOptionEntity entity2 = createTrimExtraOptionEntity(
                4L, "option4", "img4", OptionCategory.EXTERIOR, 2000, 31.2f
        );
        TrimExtraOptionEntity entity3 = createTrimExtraOptionEntity(
                6L, "option6", "img6", OptionCategory.EXTERIOR, 3000, 31.2f
        );
        TrimExtraOptionEntity entity4 = createTrimExtraOptionEntity(
                8L, "option8", "img8", OptionCategory.EXTERIOR, 5000, 31.2f
        );

        //when
        List<TrimExtraOptionEntity> options = optionsMapper.findTrimExtraOptions(trimId);

        //then
        softly.assertThat(options).as("트림이 추가할 수 있는 옵션의 개수")
                .hasSize(4);
        softly.assertThat(options).as("트림이 추가할 수 있는 옵션의 정보")
                .containsExactly(entity1, entity2, entity3, entity4);
        softly.assertAll();
    }

    @Test
    @DisplayName("특정 트림의 기본 옵션을 조회하면 TrimDefaultEntity로 반환한다.")
    @Sql("classpath:db/options/option-data.sql")
    void findTrimDefaultOptions() {
        //given
        Long trimId = 1L;
        TrimDefaultOptionEntity entity1 = createTrimDefaultOptionEntity(
                2L, "option2", "img2", OptionCategory.SAFETY, 20.0f
        );
        TrimDefaultOptionEntity entity2 = createTrimDefaultOptionEntity(
                3L, "option3", "img3", OptionCategory.EXTERIOR, 20.0f
        );
        TrimDefaultOptionEntity entity3 = createTrimDefaultOptionEntity(
                5L, "option5", "img5", OptionCategory.EXTERIOR, 20.0f
        );
        TrimDefaultOptionEntity entity4 = createTrimDefaultOptionEntity(
                7L, "option7", "img7", OptionCategory.EXTERIOR, 20.0f
        );
        TrimDefaultOptionEntity entity5 = createTrimDefaultOptionEntity(
                9L, "option9", "img9", OptionCategory.EXTERIOR, 20.0f
        );

        //when
        List<TrimDefaultOptionEntity> options = optionsMapper.findTrimDefaultOptions(trimId);

        //then
        softly.assertThat(options).as("트림이 추가할 수 있는 옵션의 개수")
                .hasSize(5);
        softly.assertThat(options).as("트림이 추가할 수 있는 옵션의 정보")
                .containsExactly(entity1, entity2, entity3, entity4, entity5);
        softly.assertAll();
    }

    @Test
    @DisplayName("트림의 ID로 해당 트림의 기본 옵션의 개수를 조회할 수 있다.")
    @Sql("classpath:db/options/option-data.sql")
    void findTrimDefaultOptionOffsetRangeWhenExist() {
        //given
        Long trimId1 = 1L;
        Long trimId2 = 2L;

        //when
        Long countDefaultOptions1 = optionsMapper.findTrimOptionSize(trimId1, OptionType.DEFAULT);
        Long countDefaultOptions2 = optionsMapper.findTrimOptionSize(trimId2, OptionType.DEFAULT);

        //then
        softly.assertThat(countDefaultOptions1).as("트림에 포함되는 기본 옵션이 있다.")
                .isEqualTo(5L);
        softly.assertThat(countDefaultOptions2).as("트림에 포함되는 기본 옵션이 없다.")
                .isEqualTo(0L);
        softly.assertAll();
    }

    @Test
    @DisplayName("트림의 ID와 기본 옵션의 범위로 조회하면 특정 위치에서 특정 개수만큼 기본 옵션을 조회한다.")
    @Sql("classpath:db/options/option-data.sql")
    void findTrimDefaultOptionsWithRange() {
        //given
        Long trimId = 1L;
        PageRangeDto optionSizeDto = PageRangeDto.of(2L, 2L);

        TrimDefaultOptionEntity entity1 = createTrimDefaultOptionEntity(
                5L, "option5", "img5", OptionCategory.EXTERIOR, 20.0f
        );
        TrimDefaultOptionEntity entity2 = createTrimDefaultOptionEntity(
                7L, "option7", "img7", OptionCategory.EXTERIOR, 20.0f
        );

        //when
        List<TrimDefaultOptionEntity> options = optionsMapper.findTrimDefaultOptionsWithRange(trimId, optionSizeDto);

        //then
        softly.assertThat(options).as("기본 옵션 2개를 조회한다.")
                .hasSize(2);
        softly.assertThat(options).as("옵션은 특정 위치에서 특정 개수만큼 조회된다.")
                .containsExactly(entity1, entity2);
        softly.assertAll();
    }

    private TrimExtraOptionEntity createTrimExtraOptionEntity(
            long id, String name, String img, OptionCategory category, int price, float choiceRatio
    ) {
        return TrimExtraOptionEntity.builder()
                .id(id)
                .name(name)
                .image(img)
                .category(category)
                .price(price)
                .choiceRatio(choiceRatio)
                .build();
    }

    private TrimDefaultOptionEntity createTrimDefaultOptionEntity(
        long id, String name, String img, OptionCategory category, float useCount
    ) {
        return TrimDefaultOptionEntity.builder()
                .id(id)
                .name(name)
                .image(img)
                .category(category)
                .choiceRatio(null)
                .useCount(useCount)
                .build();
    }
}
