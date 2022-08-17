import 'dart:convert';

import 'package:covid19_tracker_app_using_apis/models/example.dart';
import 'package:covid19_tracker_app_using_apis/services/utilities/app_url.dart';
import 'package:http/http.dart' as http;

class StatesServices {
  Future<AutoGenerate> worldStatesRecords() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return AutoGenerate.fromJson(data);
    } else {
      throw Exception("Error");
    }
  }

  Future<List<dynamic>> countriesRecordsApi() async {
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return data;
    } else {
      throw Exception("Error");
    }
  }
}
