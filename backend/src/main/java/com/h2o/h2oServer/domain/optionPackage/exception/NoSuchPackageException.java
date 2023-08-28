package com.h2o.h2oServer.domain.optionPackage.exception;

public class NoSuchPackageException extends RuntimeException {
    public NoSuchPackageException() {
        super("존재하지 않는 패키지에 대한 요청입니다.");
    }

    public NoSuchPackageException(String message) {
        super(message);
    }
}
