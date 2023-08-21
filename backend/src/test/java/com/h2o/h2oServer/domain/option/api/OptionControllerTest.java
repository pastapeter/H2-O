package com.h2o.h2oServer.domain.option.api;

import com.h2o.h2oServer.domain.option.application.OptionService;
import com.h2o.h2oServer.domain.option.dto.OptionDetailsDto;
import com.h2o.h2oServer.domain.trim.Exception.NoSuchTrimException;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.web.servlet.MockMvc;

import static com.h2o.h2oServer.domain.option.HashTagFixture.*;
import static com.h2o.h2oServer.domain.option.OptionFixture.*;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(controllers = OptionController.class)
@AutoConfigureMockMvc
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
}
