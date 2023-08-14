package com.h2o.h2oServer.domain.option.entity.enums;

public enum HashTag {
    LEISURE("레저"),
    SPORTS("스포츠"),
    MOVIE("영화감상"),
    CAMPING("캠핑"),
    STYLE("스타일"),
    SMART("스마트"),
    COMFORTABLE("쾌적"),
    LONG_DISTANCE_DRIVING("장거리 운전"),
    SHORT_DISTANCE_DRIVING("단거리 운전"),
    CHILD_COMMUTE("자녀 통학"),
    COMMUTE("출퇴근"),
    BUSINESS_TRIP("출장"),
    SAFETY("안전"),
    PARKING("주차/출차"),
    CHILDREN("자녀"),
    SINGLE_HOUSEHOLD("1인가구"),
    COUPLE("부부"),
    MULTI_PERSON_FAMILY("다인가족"),
    EYE_CATCHER("눈길"),
    CLOUDY_DAY("흐린날"),
    BEGINNER_DRIVING("초보운전"),
    HIGHWAY("고속도로"),
    NATIONAL_ROAD("국도"),
    NIGHT("야간"),
    URBAN("도시"),
    RURAL("시외"),
    FEMALE("여성"),
    MALE("남성"),
    PET("반려견/묘");

    private final String label;

    HashTag(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }

    public static HashTag fromLabel(String label) {
        for (HashTag hashTag : HashTag.values()) {
            if (hashTag.getLabel().equals(label)) {
                return hashTag;
            }
        }
        throw new IllegalArgumentException("존재하지 않는 해시태그 라벨 : " + label);
    }
}
