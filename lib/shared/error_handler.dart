import 'dart:developer';

import 'package:dio/dio.dart';

class ExceptionHandler {
  static handleError(dynamic e) {
    dynamic errorMessage = 'An unexpected error occurred';

    if (e is DioException) {
      log("======================xxxx=======================");
      log(e.response.toString());
      log(e.response!.statusCode.toString());
      log("======================xxxx=======================");
      if (e.response != null) {
        if (e.response!.data["detail"] != null) {
          errorMessage = e.response!.data['detail'].toString();
        } else if (e.response!.data['message'] != null) {
          errorMessage = e.response!.data['message'];
        } else if (e.response!.data['error'] != null) {
          errorMessage = e.response!.data.toString();
        } else if (e.response!.data['non_field_errors'] != null) {
          errorMessage = e.response!.data['non_field_errors'][0];
        } else if (e.response!.data['error_description'] != null) {
          errorMessage = e.response!.data['error_description'];
        } else if (e.response!.data['error'] != null) {
          errorMessage = e.response!.data['error'];
        } else if (e.response!.data['errors'] != null) {
          errorMessage = e.response!.data['errors'].toString();
        } else if (e.response!.data['error_message'] != null) {
          errorMessage = e.response!.data['error_message'];
        } else if (e.response!.data['error_description'] != null) {
          errorMessage = e.response!.data['error_description'];
        } else if (e.response!.data['error'] != null) {
          errorMessage = e.response!.data['error'];
        } else if (e.response!.data['error_message'] != null) {
          errorMessage = e.response!.data['error_message'];
        } else if (e.response!.data['error_description'] != null) {
          errorMessage = e.response!.data['error_description'];
        } else if (e.response!.data['error'] != null) {
          errorMessage = e.response!.data['error'];
        } else if (e.response!.data['error_message'] != null) {
          errorMessage = e.response!.data['error_message'];
        } else if (e.response!.data['error_description'] != null) {
          errorMessage = e.response!.data['error_description'];
        } else if (e.response!.data['error'] != null) {
          errorMessage = e.response!.data['error'];
        } else if (e.response!.data['error_message'] != null) {
          errorMessage = e.response!.data['error_message'];
        } else if (e.response!.data['error_description'] != null) {
          errorMessage = e.response!.data['error_description'];
        } else if (e.response!.data['error'] != null) {
          errorMessage = e.response!.data['error'];
        } else if (e.response!.data['error_message'] != null) {
          errorMessage = e.response!.data['error_message'];
        } else if (e.response!.data['error_description'] != null) {
          errorMessage = e.response!.data['error_description'];
        } else if (e.response!.data['error'] != null) {
          errorMessage = e.response!.data['error'];
        }
      } else {
        errorMessage = e.message;
      }
    }
    print(e);

    return errorMessage;
  }
}
