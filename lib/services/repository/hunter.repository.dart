import 'dart:convert';

import 'package:cazdata_frontend/model/hunter.dart';
import 'package:cazdata_frontend/services/networking/api-provider.dart';
import 'package:cazdata_frontend/util/url.dart';

class HunterRepository {
  ApiProvider _provider = ApiProvider();

  Future<bool> createHunter(Hunter user, String idToken) async {
    final String url = Url.apiBaseUrl + "/hunters";

    var requestBody = jsonEncode(user);
    final response = await _provider.post(url, requestBody, idToken);

    return response;
  }
}