package com.h2o.h2oServer.domain.options.dto;

import com.h2o.h2oServer.domain.option.dto.HashTagDto;
import com.h2o.h2oServer.domain.option.entity.HashTagEntity;
import com.h2o.h2oServer.domain.option.entity.enums.HashTag;
import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.Collections;
import java.util.List;

class HashTagDtoTest {

    @Test
    @DisplayName("다수의 해시태그 DTO를 해시태그 이름 순으로 정렬할 수 있다.")
    void hashTagOrdering() {
        //given
        HashTagEntity hashTag1 = HashTagEntity.builder().name(HashTag.CAMPING).build();
        HashTagEntity hashTag2 = HashTagEntity.builder().name(HashTag.CHILD_COMMUTE).build();
        HashTagEntity hashTag3 = HashTagEntity.builder().name(HashTag.COMMUTE).build();
        HashTagEntity hashTag4 = HashTagEntity.builder().name(HashTag.COUPLE).build();

        List<HashTagEntity> actualHashTags = List.of(hashTag1, hashTag2, hashTag3, hashTag4);
        List<HashTagEntity> expectedHashTags = List.of(hashTag4, hashTag2, hashTag3, hashTag1);

        List<HashTagDto> actualHashTagDtos = HashTagDto.listOf(actualHashTags);
        List<HashTagDto> expectedHashTagDtos = HashTagDto.listOf(expectedHashTags);

        //when
        Collections.sort(actualHashTagDtos);

        //then
        Assertions.assertThat(actualHashTagDtos).isEqualTo(expectedHashTagDtos);
    }

}
