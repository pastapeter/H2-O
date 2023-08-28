package com.h2o.h2oServer.domain.option.api;

import com.h2o.h2oServer.domain.option.HashTagFixture;
import com.h2o.h2oServer.domain.option.application.OptionService;
import com.h2o.h2oServer.domain.option.dto.OptionDetailsDto;
import com.h2o.h2oServer.domain.option.entity.enums.OptionCategory;
import com.h2o.h2oServer.domain.option.dto.TrimDefaultOptionDto;
import com.h2o.h2oServer.domain.option.dto.TrimExtraOptionDto;
import com.h2o.h2oServer.domain.option.entity.TrimDefaultOptionEntity;
import com.h2o.h2oServer.domain.option.entity.TrimExtraOptionEntity;
import com.h2o.h2oServer.domain.trim.Exception.NoSuchTrimException;
import com.h2o.h2oServer.global.config.RedisConfig;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.context.annotation.Import;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import java.util.ArrayList;
import java.util.List;

import static com.h2o.h2oServer.domain.option.HashTagFixture.*;
import static com.h2o.h2oServer.domain.option.OptionFixture.*;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;

@WebMvcTest(controllers = OptionController.class)
@AutoConfigureMockMvc
@Import(RedisConfig.class)
class OptionControllerTest {
    @Autowired
    MockMvc mockMvc;
    @MockBean
    OptionService optionService;

    @Nested
    @DisplayName("옵션 세부 정보 조회 테스트")
    class getOptionInformation {
        @Test
        @DisplayName("존재하는 trim, option id 요청에 대해서 InternalColorDto를 응답한다.")
        void withValidTrimId() throws Exception {
            // given
            Long trimId = 1L;
            Long optionId = 1L;

            OptionDetailsDto expectedOptionDetailsDto = OptionDetailsDto.of(generateOptionDetailsEntity()
                    , generateHashTagEntities());

            when(optionService.findDetailedOptionInformation(trimId, optionId)).thenReturn(expectedOptionDetailsDto);

            // when
            mockMvc.perform(get("/trim/{trimId}/option/{optionId}", trimId, optionId))
                    //then
                    .andDo(print())
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.name").value(expectedOptionDetailsDto.getName()))
                    .andExpect(jsonPath("$.category").value(expectedOptionDetailsDto.getCategory()))
                    .andExpect(jsonPath("$.hashTags").isArray())
                    .andExpect(jsonPath("$.hashTags.length()").value(expectedOptionDetailsDto.getHashTags().size()))
                    .andExpect(jsonPath("$.hashTags[0]").value(expectedOptionDetailsDto.getHashTags().get(0)))
                    .andExpect(jsonPath("$.hashTags[1]").value(expectedOptionDetailsDto.getHashTags().get(1)))
                    .andExpect(jsonPath("$.image").value(expectedOptionDetailsDto.getImage()))
                    .andExpect(jsonPath("$.description").value(expectedOptionDetailsDto.getDescription()))
                    .andExpect(jsonPath("$.price").value(expectedOptionDetailsDto.getPrice()))
                    .andExpect(jsonPath("$.containsChoiceCount").value(expectedOptionDetailsDto.isContainsChoiceCount()))
                    .andExpect(jsonPath("$.containsUseCount").value(expectedOptionDetailsDto.isContainsUseCount()))
                    .andExpect(jsonPath("$.hmgData.isOverHalf").value(expectedOptionDetailsDto.getHmgData().getIsOverHalf()))
                    .andExpect(jsonPath("$.hmgData.choiceCount").value(expectedOptionDetailsDto.getHmgData().getChoiceCount()))
                    .andExpect(jsonPath("$.hmgData.useCount").value(expectedOptionDetailsDto.getHmgData().getUseCount()));
        }

        @Test
        @DisplayName("존재하지 않는 trim 요청에 대해서 NotFound로 응답한다.")
        void withInvalidTrim() throws Exception {
            //given
            Long trimId = 1L;
            Long optionId = 1L;

            when(optionService.findDetailedOptionInformation(trimId, optionId)).thenThrow(new NoSuchTrimException());
            // todo : optionId, trimId 중 어느 쪽이 유효하지 않은 지 구분하는 테스트 코드

            //when
            mockMvc.perform(get("/trim/{trimId}/option/{optionId}", trimId, optionId))
                    //then
                    .andDo(print())
                    .andExpect(status().isNotFound());
        }
    }

    @Nested
    @DisplayName("추가 옵션 조회 테스트")
    class GetExtraOptionsTest {
        @Test
        @DisplayName("존재하는 trim Id 요청일 경우 TrimExtraOptionDto를 응답한다.")
        void withValidTrim() throws Exception {
            //given
            Long trimId = 1L;
            List<TrimExtraOptionDto> expectedTrimExtraOptionDto = generateTrimExtraOptionDtoList(2);
            when(optionService.findTrimExtraOptions(trimId)).thenReturn(expectedTrimExtraOptionDto);

            //when
            mockMvc.perform(get("/trim/{trimId}/extra-option", trimId))
                    //then
                    .andDo(print())
                    .andExpect(status().isOk())
                    .andExpect(content().contentType(MediaType.APPLICATION_JSON))
                    .andExpect(jsonPath("$").isArray())
                    .andExpect(jsonPath("$.length()").value(expectedTrimExtraOptionDto.size()))
                    .andExpect(jsonPath("$[0].id").value(expectedTrimExtraOptionDto.get(0).getId()))
                    .andExpect(jsonPath("$[0].category").value(expectedTrimExtraOptionDto.get(0).getCategory()))
                    .andExpect(jsonPath("$[0].name").value(expectedTrimExtraOptionDto.get(0).getName()))
                    .andExpect(jsonPath("$[0].image").value(expectedTrimExtraOptionDto.get(0).getImage()))
                    .andExpect(jsonPath("$[0].price").value(expectedTrimExtraOptionDto.get(0).getPrice()))
                    .andExpect(jsonPath("$[0].containsHmgData").value(expectedTrimExtraOptionDto.get(0).isContainsHmgData()))
                    .andExpect(jsonPath("$[0].isPackage").value(expectedTrimExtraOptionDto.get(0).getIsPackage()))
                    .andExpect(jsonPath("$[0].choiceRatio").value(expectedTrimExtraOptionDto.get(0).getChoiceRatio()))
                    .andExpect(jsonPath("$[0].hashTags").isArray())
                    .andExpect(jsonPath("$[0].hashTags.length()").value(expectedTrimExtraOptionDto.get(0).getHashTags().size()));
        }

        @Test
        @DisplayName("존재하지 않는 trim Id 요청에 대해서 NotFound로 응답한다.")
        void withInvalidTrim() throws Exception {
            //given
            Long trimId = 1L;

            when(optionService.findTrimExtraOptions(trimId)).thenThrow(new NoSuchTrimException());

            //when
            mockMvc.perform(get("/trim/{trimId}/extra-option", trimId))
                    //then
                    .andDo(print())
                    .andExpect(status().isNotFound());
        }


        private TrimExtraOptionDto generateTrimExtraOptionDto() {
            return TrimExtraOptionDto.of(
                    false,
                    generateTrimExtraOptionEntity(),
                    generateHashTagEntities()
            );
        }

        private List<TrimExtraOptionDto> generateTrimExtraOptionDtoList(int count) {
            List<TrimExtraOptionDto> dtos = new ArrayList<>();
            for (int i = 0; i < count; i++) {
                dtos.add(generateTrimExtraOptionDto());
            }
            return dtos;
        }

        private TrimExtraOptionEntity generateTrimExtraOptionEntity() {
            return TrimExtraOptionEntity.builder()
                    .id(1L)
                    .category(OptionCategory.CONVENIENCE)
                    .name("Option Name")
                    .image("option_image")
                    .price(1000)
                    .choiceRatio(0.2f)
                    .build();
        }
    }

    @Nested
    @DisplayName("기본 옵션 조회 테스트")
    class GetDefaultOptionsTest {
        @Test
        @DisplayName("존재하는 trim Id 요청일 경우 TrimDefaultOptionDto를 응답한다.")
        void withValidTrim() throws Exception {
            //given
            Long trimId = 1L;
            List<TrimDefaultOptionDto> expectedTrimDefaultOptionDto = List.of(
                    TrimDefaultOptionDto.of(generateTrimDefaultOptionEntitiy(), HashTagFixture.generateHashTagEntities()),
                    TrimDefaultOptionDto.of(generateTrimDefaultOptionEntitiy(), HashTagFixture.generateHashTagEntities())
            );
            when(optionService.findTrimDefaultOptions(trimId)).thenReturn(expectedTrimDefaultOptionDto);

            //when
            mockMvc.perform(get("/trim/{trimId}/default-option", trimId))
                    //then
                    .andDo(print())
                    .andExpect(status().isOk())
                    .andExpect(content().contentType(MediaType.APPLICATION_JSON))
                    .andExpect(jsonPath("$").isArray())
                    .andExpect(jsonPath("$.length()").value(expectedTrimDefaultOptionDto.size()))
                    .andExpect(jsonPath("$[0].id").value(expectedTrimDefaultOptionDto.get(0).getId()))
                    .andExpect(jsonPath("$[0].category").value(expectedTrimDefaultOptionDto.get(0).getCategory()))
                    .andExpect(jsonPath("$[0].name").value(expectedTrimDefaultOptionDto.get(0).getName()))
                    .andExpect(jsonPath("$[0].image").value(expectedTrimDefaultOptionDto.get(0).getImage()))
                    .andExpect(jsonPath("$[0].hashTags").isArray())
                    .andExpect(jsonPath("$[0].hashTags.length()").value(expectedTrimDefaultOptionDto.get(0).getHashTags().size()))
                    .andExpect(jsonPath("$[0].containsHmgData").value(expectedTrimDefaultOptionDto.get(0).isContainsHmgData()))
                    .andExpect(jsonPath("$[1].id").value(expectedTrimDefaultOptionDto.get(1).getId()))
                    .andExpect(jsonPath("$[1].category").value(expectedTrimDefaultOptionDto.get(1).getCategory()))
                    .andExpect(jsonPath("$[1].name").value(expectedTrimDefaultOptionDto.get(1).getName()));
        }

        @Test
        @DisplayName("존재하지 않는 trim Id 요청에 대해서 NotFound로 응답한다.")
        void withInvalidTrim() throws Exception {
            //given
            Long trimId = 1L;

            when(optionService.findTrimDefaultOptions(trimId)).thenThrow(new NoSuchTrimException());

            //when
            mockMvc.perform(get("/trim/{trimId}/default-option", trimId))
                    //then
                    .andDo(print())
                    .andExpect(status().isNotFound());
        }

        private TrimDefaultOptionEntity generateTrimDefaultOptionEntitiy() {
            return TrimDefaultOptionEntity.builder()
                    .id(1L)
                    .category(OptionCategory.CONVENIENCE)
                    .name("name")
                    .useCount(0.3f)
                    .image("image")
                    .build();
        }
    }
}
