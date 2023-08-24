package com.h2o.h2oServer.domain.options.api;

import com.h2o.h2oServer.domain.option.HashTagFixture;
import com.h2o.h2oServer.domain.option.entity.enums.OptionCategory;
import com.h2o.h2oServer.domain.options.application.OptionsService;
import com.h2o.h2oServer.domain.options.dto.TrimDefaultOptionDto;
import com.h2o.h2oServer.domain.options.dto.TrimExtraOptionDto;
import com.h2o.h2oServer.domain.options.entity.TrimDefaultOptionEntity;
import com.h2o.h2oServer.domain.options.entity.TrimExtraOptionEntity;
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

import static com.h2o.h2oServer.domain.option.HashTagFixture.generateHashTagEntities;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(controllers = OptionsController.class)
@AutoConfigureMockMvc
@Import(RedisConfig.class)
class OptionsControllerTest {
    @Autowired
    MockMvc mockMvc;
    @MockBean
    OptionsService optionsService;

    @Nested
    @DisplayName("추가 옵션 조회 테스트")
    class GetExtraOptionsTest {
        @Test
        @DisplayName("존재하는 trim Id 요청일 경우 TrimExtraOptionDto를 응답한다.")
        void withValidTrim() throws Exception {
            //given
            Long trimId = 1L;
            List<TrimExtraOptionDto> expectedTrimExtraOptionDto = generateTrimExtraOptionDtoList(2);
            when(optionsService.findTrimExtraOptions(trimId)).thenReturn(expectedTrimExtraOptionDto);

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

            when(optionsService.findTrimExtraOptions(trimId)).thenThrow(new NoSuchTrimException());

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
            when(optionsService.findTrimDefaultOptions(trimId)).thenReturn(expectedTrimDefaultOptionDto);

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

            when(optionsService.findTrimDefaultOptions(trimId)).thenThrow(new NoSuchTrimException());

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
