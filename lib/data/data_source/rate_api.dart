import 'dart:convert';

import 'package:exchange_currency/data/dto/exchange_dto.dart';
import 'package:http/http.dart' as http;

class RateApi {
  Future<Map<String, dynamic>> getRate(String baseCode) async {
    final response = await http.get(Uri.parse('https://open.er-api.com/v6/latest/$baseCode'));
    // print('asdasds');
    // print(jsonDecode(response.body));

    return jsonDecode(response.body);
  }
}