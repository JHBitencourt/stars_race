import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

const baseUrl = 'https://api.github.com/repos/';
const timeoutSeconds = 20;

class BaseApi {

  Future<dynamic> getPublic(String url) async {
    final response = await http.get(
      url
    ).timeout(
      const Duration(seconds: timeoutSeconds),
      onTimeout: _onTimeout,
    );

    return _responseRequest(response);
  }

  Future<dynamic> _responseRequest(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson;

        if (response.body.isNotEmpty) {
          responseJson = json.decode(
            utf8.decode(response.bodyBytes),
          );
        }

        return Future.value(responseJson);
      default:
        throw HttpException('Status diferente de 200');
    }
  }

  Future<http.Response> _onTimeout() {
    throw SocketException("Timeout during request");
  }

}