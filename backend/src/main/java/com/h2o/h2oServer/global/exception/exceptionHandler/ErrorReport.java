package com.h2o.h2oServer.global.exception.exceptionHandler;

import javax.servlet.http.HttpServletRequest;

public class ErrorReport {
    private static final String ERROR_REPORT_FORMAT = "[%s] %s";

    private final HttpServletRequest request;
    private final Exception exception;

    public ErrorReport(HttpServletRequest request, Exception exception) {
        this.request = request;
        this.exception = exception;
    }

    public String log() {
        String requestUri = request.getRequestURI();
        String requestMethod = request.getMethod();

        return String.format(ERROR_REPORT_FORMAT, requestMethod, requestUri);
    }

    public HttpServletRequest getRequest() {
        return request;
    }

    public Exception getException() {
        return exception;
    }
}
