package com.h2o.h2oServer.global.exception;

import lombok.Data;

@Data
public class ErrorResponse {
    private String message;

    private ErrorResponse(String message) {
        this.message = message;
    }

    public static ErrorResponse of(String message) {
        return new ErrorResponse(message);
    }
}
