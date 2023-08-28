package com.h2o.h2oServer.domain.trim.Exception;

public class NoSuchExternalColorException extends RuntimeException {
    public NoSuchExternalColorException(String message) {
        super(message);
    }

    public NoSuchExternalColorException() {
        super("존재하지 않는 외장 색상입니다.");
    }
}
