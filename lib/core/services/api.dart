import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:anywhere/core/components/endpoints.dart';
import 'package:anywhere/core/model/item_response_model.dart';
import 'package:http/http.dart' as http;

class Api {
  final client = http.Client();
  final Duration timeOutDuration = const Duration(seconds: 50);

  int attempt = 1;
  int totalAttempt = 2;
  int timerCount = 0;

  onException(dynamic error) {
    print(error);
    if (error is SocketException) {
      return "Please Check Your Internet Connection";
    }

    if (error is TimeoutException) {
      return "Server not Responding, please try again";
    } else {
      if (attempt > totalAttempt) {
        attempt = 1;
      }
      attempt++;
      if (attempt <= totalAttempt) {
        print("Attempt $attempt");
        return false;
      } else {
        return "Oops Something Went Wrong";
      }
    }
  }

  Future<ItemResponseModel> getItems() async {
    String url = wireCharacterEndpoint;
    print("url : $url");
    final stopwatch = Stopwatch()..start();
    try {
      var response = await http
          .get(
            Uri.parse(url),
          )
          .timeout(timeOutDuration);
      print('Time Taken - ${stopwatch.elapsed}');
      print('The response from banner: ${response.body}');
      return ItemResponseModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      var data = onException(e);
      return data is bool
          ? await getItems()
          : ItemResponseModel.withError(data);
    }
  }


}
