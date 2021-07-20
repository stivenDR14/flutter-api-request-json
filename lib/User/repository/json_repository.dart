import 'json_api.dart';

class JsonRepository {
  final _jsonAPI= JsonAPI();

  Future getDataJson()=> _jsonAPI.getData();
}