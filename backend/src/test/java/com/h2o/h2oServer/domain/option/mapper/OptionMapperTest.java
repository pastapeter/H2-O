package com.h2o.h2oServer.domain.option.mapper;

import com.h2o.h2oServer.domain.option.HashTagFixture;
import com.h2o.h2oServer.domain.option.OptionFixture;
import com.h2o.h2oServer.domain.option.entity.HashTagEntity;
import com.h2o.h2oServer.domain.option.entity.OptionDetailsEntity;
import com.h2o.h2oServer.domain.option.entity.enums.OptionCategory;
import com.h2o.h2oServer.domain.option.entity.TrimDefaultOptionEntity;
import com.h2o.h2oServer.domain.option.entity.TrimExtraOptionEntity;
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
        List<TrimExtraOptionEntity> packages = optionMapper.findTrimPackages(trimId);

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
        List<TrimExtraOptionEntity> options = optionMapper.findTrimExtraOptions(trimId);

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
        List<TrimDefaultOptionEntity> options = optionMapper.findTrimDefaultOptions(trimId);

        //then
        softly.assertThat(options).as("트림이 추가할 수 있는 옵션의 개수")
                .hasSize(5);
        softly.assertThat(options).as("트림이 추가할 수 있는 옵션의 정보")
                .containsExactly(entity1, entity2, entity3, entity4, entity5);
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
