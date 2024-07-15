import 'dart:developer';

import 'package:dio/dio.dart';

class ExceptionHandler {
  static handleError(dynamic e) {
    String? errorMessage = 'An unexpected error occurred';

    if (e is DioException) {
      log(e.response!.data.toString());
      // Check if the error is because of a bad request or other HTTP errors
      if (e.response != null) {
        // Attempt to extract the error message from the response
        if (e.response!.data['detail'] != null) {
          errorMessage = e.response!.data['detail'];
        } else if (e.response!.data['message'] != null) {
          errorMessage = e.response!.data['message'];
        } else if (e.response!.data['error'] != null) {
          errorMessage = e.response!.data.toString();
        } else {
          errorMessage = e.response!.data.toString();
        }
      } else {
        // Error due to sending the request or receiving the response
        errorMessage = e.message;
      }
    }
    return errorMessage;
  }
}
