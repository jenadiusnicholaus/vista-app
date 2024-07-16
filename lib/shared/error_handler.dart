import 'dart:developer';

import 'package:dio/dio.dart';

class ExceptionHandler {
  static handleError(dynamic e) {
    dynamic errorMessage = 'An unexpected error occurred';

    if (e is DioException) {
      log("======================xxxx=======================");
      log(e.response.toString());
      log("======================xxxx=======================");

      if (e.response != null) {
        if (e.response!.data["derail"] != null) {
          errorMessage = e.response!.data['derail'].toString();
        } else if (e.response!.data['message'] != null) {
          errorMessage = e.response!.data['message'];
        } else if (e.response!.data['error'] != null) {
          errorMessage = e.response!.data.toString();
        } else {
          errorMessage = e.response!.data.toString();
        }
      } else {
        log("message");
        log(e.message.toString());
        // Error due to sending the request or receiving the response
        errorMessage = e.message;
      }
    }
    return errorMessage;
  }
}
