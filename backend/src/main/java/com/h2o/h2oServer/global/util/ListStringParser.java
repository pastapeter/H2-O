package com.h2o.h2oServer.global.util;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class ListStringParser {
    public static List<Long> parseToLongList(String string) {
        if (string == null || string.isEmpty()) {
            throw new IllegalArgumentException("입력값은 null, 빈 값이 될 수 없습니다.");
        }

        try {
            return Arrays.stream(string.split(","))
                    .map(Long::parseLong)
                    .collect(Collectors.toList());
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("입력 형식이 잘못되었습니다.");
        }
    }

    public static String parseToString(List<Long> list) {
        if (list == null) {
            throw new IllegalArgumentException("입력값은 null이 될 수 없습니다.");
        }

        return list.stream()
                .map(String::valueOf)
                .collect(Collectors.joining(","));
    }
}
