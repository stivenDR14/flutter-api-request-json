import 'package:dio/dio.dart';


class JsonAPI {

  Future getData() async {
    print("comienza...");
    try {
      return Dio().get('https://jsonplaceholder.typicode.com/users');

    } catch (e) {
      print(e);
      throw(e);
    }
  }


}