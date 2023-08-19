package com.h2o.h2oServer.global.util;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class StringParser {
    public static List<Long> parseToLongList(String string) {
        return Arrays.stream(string.split(","))
                .map(Long::parseLong)
                .collect(Collectors.toList());
    }
}
