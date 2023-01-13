import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_app/data/config.dart';
import 'package:http/http.dart' as http;

import 'package:food_app/res/res.dart';
import 'package:food_app/data/app_exceptions.dart';
import 'package:food_app/data/network/base_api_services.dart';

class NetworkApiServices extends BaseApiServices {
  dynamic responseJson;

  @override
  Future getGetApiResponse(String url) async {
    final autorization = prefs.getTokenApp == ''
        ? {
            "Authorization": 'Bearer ${prefs.getTokenApp}',
            "apiKey": AppUrl.apiKey,
          }
        : {
            "": "",
            "apiKey": AppUrl.apiKey,
          };
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: autorization,
      );
      responseJson = returnResponse(response);
      debugPrint(response.body.toString());
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;

    try {
      final response = await http
          .post(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = response.body.toString();
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 404:
        throw BadRequestException(response.body.toString());
      case 500:
        throw BadRequestException(response.body.toString());
      default:
        throw FetchDataException(
          "Error accourded while communicating with server with status code ${response.statusCode}",
        );
    }
  }
}
