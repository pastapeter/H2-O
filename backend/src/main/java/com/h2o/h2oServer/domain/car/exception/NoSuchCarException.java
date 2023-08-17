package com.h2o.h2oServer.domain.car.exception;

public class NoSuchCarException extends RuntimeException {
    public NoSuchCarException(String message) {
        super(message);
    }

    public NoSuchCarException() {
        super("존재하지 않는 차종에 대한 요청입니다.");
    }
}
