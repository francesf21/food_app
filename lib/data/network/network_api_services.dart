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
    final headers = prefs.getTokenApp != ''
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
        headers: headers,
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
      final headers = prefs.getTokenApp != ''
          ? {
              "Authorization": 'Bearer ${prefs.getTokenApp}',
              "apiKey": AppUrl.apiKey,
              "Content-Type": "application/json",
              "Prefer": "return=minimal"
            }
          : {
              "": "",
              "apiKey": AppUrl.apiKey,
              "Content-Type": "application/json",
              "Prefer": "return=minimal"
            };

      final response = await http
          .post(Uri.parse(url), body: data, headers: headers)
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
      debugPrint(response.body.toString());
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future getPatchApiResponse(String url, dynamic data) async {
    final headers = prefs.getTokenApp != ''
        ? {
            "Authorization": 'Bearer ${prefs.getTokenApp}',
            "apiKey": AppUrl.apiKey,
            "Content-Type": "application/json",
          }
        : {
            "": "",
            "apiKey": AppUrl.apiKey,
            "Content-Type": "application/json",
          };
    try {
      final response = await http.patch(
        Uri.parse(url),
        headers: headers,
        body: data,
      );
      responseJson = returnResponse(response);
      debugPrint(response.body.toString());
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
      case 201:
        dynamic responseJson = "Se creó el registro correctamente";
        return responseJson;
      case 204:
        dynamic responseJson = "Se a actualizado la información";
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
