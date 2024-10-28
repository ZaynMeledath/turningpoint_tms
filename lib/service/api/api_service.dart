// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:turningpoint_tms/preferences/app_preferences.dart';
import 'package:turningpoint_tms/service/api/api_exceptions.dart';

enum RequestMethod {
  GET,
  POST,
  PATCH,
  PUT,
  DELETE,
}

class ApiService {
  String? token;

  Future sendRequest({
    required String url,
    required RequestMethod requestMethod,
    required dynamic data,
    required String? fieldNameForFiles,
    required bool isTokenRequired,
  }) async {
    const timeOutSeconds = 10;
    data ??= {};
    dynamic responseJson;
    if (isTokenRequired) {
      token = await AppPreferences.getValueShared('auth_token') ?? '';
    }
    try {
      final headers = {
        if (token != null) 'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      Response response;
      switch (requestMethod) {
        case RequestMethod.GET:
          response = await http.get(Uri.parse(url), headers: headers).timeout(
            const Duration(seconds: timeOutSeconds),
            onTimeout: () {
              return http.Response('Request timed out', 408);
            },
          );
          break;
        case RequestMethod.POST:
          if (data is File) {
            final multiPartRequest = http.MultipartRequest(
              'POST',
              Uri.parse(url),
            );

            multiPartRequest.files.add(
                await MultipartFile.fromPath(fieldNameForFiles!, data.path));
            multiPartRequest.headers.addAll(headers);

            final streamedResponse = await multiPartRequest.send();

            response = await Response.fromStream(streamedResponse).timeout(
              const Duration(seconds: timeOutSeconds),
              onTimeout: () {
                return http.Response('Request timed out', 408);
              },
            );
          } else {
            final requestBody = data is String ? data : json.encode(data);
            response = await http
                .post(
              Uri.parse(url),
              headers: headers,
              body: requestBody,
            )
                .timeout(
              const Duration(seconds: timeOutSeconds),
              onTimeout: () {
                return http.Response('Request timed out', 408);
              },
            );
          }
          break;
        case RequestMethod.PUT:
          if (data is File) {
            final multiPartRequest = http.MultipartRequest(
              'PUT',
              Uri.parse(url),
            );

            multiPartRequest.files.add(
                await MultipartFile.fromPath(fieldNameForFiles!, data.path));
            multiPartRequest.headers.addAll(headers);

            final streamedResponse = await multiPartRequest.send();

            response = await Response.fromStream(streamedResponse).timeout(
              const Duration(seconds: timeOutSeconds),
              onTimeout: () {
                return http.Response('Request timed out', 408);
              },
            );
          } else {
            final requestBody = data is String ? data : json.encode(data);
            response = await http
                .put(
              Uri.parse(url),
              headers: headers,
              body: requestBody,
            )
                .timeout(
              const Duration(seconds: timeOutSeconds),
              onTimeout: () {
                return http.Response('Request timed out', 408);
              },
            );
          }

          break;
        case RequestMethod.PATCH:
          if (data is File) {
            final multiPartRequest = http.MultipartRequest(
              'PATCH',
              Uri.parse(url),
            );

            multiPartRequest.files.add(
                await MultipartFile.fromPath(fieldNameForFiles!, data.path));
            multiPartRequest.headers.addAll(headers);

            final streamedResponse = await multiPartRequest.send();

            response = await Response.fromStream(streamedResponse).timeout(
              const Duration(seconds: timeOutSeconds),
              onTimeout: () {
                return http.Response('Request timed out', 408);
              },
            );
          } else {
            final requestBody = data is String ? data : json.encode(data);

            response = await http
                .patch(
              Uri.parse(url),
              headers: headers,
              body: requestBody,
            )
                .timeout(
              const Duration(seconds: timeOutSeconds),
              onTimeout: () {
                return http.Response('Request timed out', 408);
              },
            );
          }

          break;
        case RequestMethod.DELETE:
          response =
              await http.delete(Uri.parse(url), headers: headers).timeout(
            const Duration(seconds: timeOutSeconds),
            onTimeout: () {
              return http.Response('Request timed out', 408);
            },
          );
          break;
        default:
          throw ArgumentError('Invalid HTTP method: $requestMethod');
      }

      responseJson = returnResponse(response);
    } on TimeoutException {
      throw TimeoutException('Request timed out');
    } on FormatException {
      throw const FormatException('Response format is not valid');
    } on UnauthenticatedException {
      token = null;
      sendUserToLoginScreen();
    }
    // on CustomException {
    //   rethrow;
    // } on NotFoundException {
    //   rethrow;
    // } on ProfileInactiveException {
    //   rethrow;
    // } on BadRequestException {
    //   rethrow;
    // }
    catch (e) {
      rethrow;
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    final statusCode = response.statusCode;
    dynamic responseJson;
    try {
      responseJson = jsonDecode(response.body);
    } catch (_) {}

    switch (statusCode) {
      case 200:
        return responseJson;
      case 202:
        throw ProfileInactiveException(responseJson.toString());
      case 204:
        throw NoContentException(responseJson.toString());
      case 400:
        throw BadRequestException(responseJson.toString());
      case 401:
        throw UnauthenticatedException(responseJson.toString());
      case 403:
        throw ForbiddenException(responseJson.toString());
      case 404:
        throw NotFoundException(responseJson.toString());
      case 408:
        throw RequestTimedOutException();
      case 500:
        throw ServerErrorException(responseJson.toString());
      case 700:
        throw CustomException(responseJson['message']);
      default:
        throw FetchDataException(
          'Error occurred while communicating with the server with status code $statusCode',
        );
    }
  }

  void sendUserToLoginScreen() async {}

  // List<dynamic> flattenList(List<dynamic> list) {
  //   return list.expand((element) {
  //     if (element is List) {
  //       // If the element is a list, recursively flatten it
  //       return flattenList(element);
  //     } else {
  //       // Otherwise, return the element itself
  //       return [element];
  //     }
  //   }).toList();
  // }
}
