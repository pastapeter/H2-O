package com.h2o.h2oServer.domain.option.exception;

public class NoSuchOptionException extends RuntimeException {
    public NoSuchOptionException() {
        super("존재하지 않는 옵션에 대한 요청입니다.");
    }

    public NoSuchOptionException(String message) {
        super(message);
    }
}
