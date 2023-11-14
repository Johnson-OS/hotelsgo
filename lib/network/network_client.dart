
import 'dart:convert';
import 'dart:io';
import 'package:hotelsgo/models/network_message.dart';
import 'package:hotelsgo/models/network_result.dart';
import 'package:hotelsgo/network/request_type.dart';
import 'package:hotelsgo/network/request_type_exception.dart';
import 'package:hotelsgo/res/strings.dart';
import 'package:http/http.dart';

class NetworkClient {
  static const String _baseUrl = Strings.baseUrl;
  late Client _client;

  NetworkClient(){
    _client = Client();
  }

  Future<NetworkResult> request({required RequestType requestType,
      required String path, dynamic body}) async {

    Response response;

    Uri url = Uri.parse('$_baseUrl/$path');

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    try {

      switch (requestType) {
        case RequestType.GET:
          response = await _client.get(url, headers: headers);
          break;
        case RequestType.POST:
          response = await _client.post(url, headers: headers, body: json.encode(body));

          break;
        case RequestType.PUT:
          response = await _client.put(url, headers: headers, body: json.encode(body));

          break;
        case RequestType.DELETE:
          response = await _client.delete(url, headers: headers);

          break;
        default:
          return throw RequestTypeNotFoundException("The HTTP request method is not found");
      }

      if (response.statusCode == 200) {

        return NetworkResult.success(response.body);
      } else {

        return NetworkResult.error(
            NetworkMessage.fromRawJson(response.body).msg
        );
      }
    } on SocketException {
      return NetworkResult.error('Connection Error. Check your internet connection');
    } on Exception catch(_){
      return NetworkResult.error('Something Went Wrong. Please try again');
    }
  }

}
