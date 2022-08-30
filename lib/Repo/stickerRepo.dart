import 'dart:convert';

import 'package:oceantodo/models/stikersmodel.dart';

import 'package:http/http.dart' as http;

abstract class StickerRepo {
  Future<Stikersmodel> fetchStiker();
}

class StickerRepoImpl extends StickerRepo {
  @override
  Future<Stikersmodel> fetchStiker() async {
    var url = Uri.parse("http://103.77.155.78/static/getSticker.json");
    final response = await http.get(url);
    var jsonresponse;
    print("statuscode:${response.statusCode}");
    if (response.statusCode == 200) {
      jsonresponse = jsonDecode(response.body);
    } else {
      throw Exception("failed get sticker");
    }
    return Stikersmodel.fromJson(jsonresponse);
  }
}
