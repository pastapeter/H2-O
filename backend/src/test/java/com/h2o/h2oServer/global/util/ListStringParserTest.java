package com.h2o.h2oServer.global.util;

import org.junit.jupiter.api.Test;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

class ListStringParserTest {
    @Test
    public void testParseToLongList() {
        List<Long> result = ListStringParser.parseToLongList("1,2,3");
        assertThat(result).containsExactly(1L, 2L, 3L);
    }

    @Test
    public void testParseToLongListWithInvalidInput() {
        assertThatThrownBy(() -> ListStringParser.parseToLongList("1,a,3"))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessageContaining("입력 형식이 잘못되었습니다.");
    }

    @Test
    public void testParseToLongListWithEmptyInput() {
        assertThatThrownBy(() -> ListStringParser.parseToLongList(""))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessageContaining("입력값은 null, 빈 값이 될 수 없습니다.");
    }

    @Test
    public void testParseToString() {
        List<Long> input = List.of(1L, 2L, 3L);
        String result = ListStringParser.parseToString(input);
        assertThat(result).isEqualTo("1,2,3");
    }

    @Test
    public void testParseToStringWithNullInput() {
        assertThatThrownBy(() -> ListStringParser.parseToString(null))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessageContaining("입력값은 null이 될 수 없습니다.");
    }
}
