import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AppService {
  Future<List> getJsonData() async {
    String url = 'http://www.json-generator.com/api/json/get/cqgLQTBEbS?indent=2';
    var response = await http.get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    return json.decode(response.body);
  }
}
