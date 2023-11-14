import 'dart:convert';

import 'package:hotelsgo/models/hotel.dart';
import 'package:hotelsgo/models/network_result.dart';
import 'package:hotelsgo/network/network_client.dart';
import 'package:hotelsgo/network/request_type.dart';

class HotelsService {
  final NetworkClient _client = NetworkClient();

  Future<NetworkResult> getHotels() async{

    try{

      var result = await _client.request(requestType: RequestType.GET, path: 'hotels');

      if(result is SuccessState){
        return NetworkResult.success(
          (jsonDecode(result.value) as List).map<Hotel>((e) => Hotel.fromJsn(e)).toList()
        );
      }else{
        return result;
      }

    }catch(_){
      return NetworkResult.error('Error. Please try again');
    }

  }

}
