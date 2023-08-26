//
//  CLNetworkError.swift
//  Catalog
//
//  Created by Jung peter on 8/8/23.
//

import Foundation

enum CLNetworkError: LocalizedError {
  case invalidURL
  case urlRequestValidationFailed(reason: CLURLRequestFailureReason)
  case retryFailed(reason: CLRetryFailureReason)
  case invalidServerResponse(reason: Int)
  case timeout
  case URLError(message: String?)
}

extension CLNetworkError {
  var errorDescription: String? {
    switch self {
    case .invalidURL:
      return "올바르지 않은 URL"
    case .urlRequestValidationFailed(let reason):
      if reason == .bodyDataInGETRequest {
        return "GET요청에는 body가 존재하지 않습니다."
      }
      return "Request 형식에 문제가 있습니다."
    case .retryFailed(let reason):
      return "여러번 시도했지만 \(reason)으로 인해 실패했습니다."
    case .invalidServerResponse(let reason):
      if reason == 403 {
        return "접근권한이 없습니다"
      } else if reason == 404 {
        return "잘못된 요청입니다."
      } else {
        return "알수없는 서버 오류입니다.\(reason)"
      }
    case .timeout:
      return "인터넷 상태를 확인해주세요 타임아웃 애러입니다."
    case .URLError(let message):
      return "URLError \(message ?? "") 애러입니다."
    }
  }
}

enum CLURLRequestFailureReason {
  case bodyDataInGETRequest
}

enum CLRetryFailureReason {
  case timeOut
}
