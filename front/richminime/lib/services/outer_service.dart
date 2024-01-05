import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class financeInfoModel {
  String? name;
  String? index;
  String? value;
  String? date;
  String? unit;

  financeInfoModel({this.name, this.index, this.value, this.date, this.unit});

  financeInfoModel.fromJson(Map<String, dynamic> json) {
    name = json['CLASS_NAME'];
    index = json['KEYSTAT_NAME'];
    value = json['DATA_VALUE'];
    date = json['CYCLE'];
    unit = json['UNIT_NAME'];
  }
}

class OuterService {
  static Future<List<financeInfoModel>> getExchangeRate() async {
    List<financeInfoModel> erInstances = [];

    final url = Uri.parse(
        'https://ecos.bok.or.kr/api/KeyStatisticList/DR84EM8D125149QBK68A/json/kr/2/5');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      // "row" 값을 추출하고 출력
      final List<dynamic> rows = responseBody['KeyStatisticList']['row'];

      for (var row in rows) {
        erInstances.add(financeInfoModel.fromJson(row));
      }

      return erInstances;
    }

    return erInstances;
  }

  static Future<List<financeInfoModel>> getEconomyNews() async {
    List<financeInfoModel> enInstances = [];
    final url = Uri.parse(
        'https://ecos.bok.or.kr/api/KeyStatisticList/DR84EM8D125149QBK68A/json/kr/51/67');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      // "row" 값을 추출하고 출력
      final rows = responseBody['KeyStatisticList']['row'];
      for (var row in rows) {
        enInstances.add(financeInfoModel.fromJson(row));
      }

      return enInstances;
    }

    return enInstances;
  }
}
