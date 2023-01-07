import 'dart:convert';
import 'dart:io';

import 'package:cheat_sheet/data/app_exception.dart';
import 'base_api_service.dart';

import 'package:http/http.dart' as http;

/*For handle error status blah blah blah
*/

class NetworkApiService extends BaseApiServices {
  @override
  Future getApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No internet connection');
    }

    return responseJson;
  }

  @override
  Future postApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      http.Response response = await http
          .post(Uri.parse(url), body: data)
          .timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No internet connection');
    }

    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 404:
        throw UnauthorizeException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occurred with status code' + response.statusCode.toString());
    }
  }
}
