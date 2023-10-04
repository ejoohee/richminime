import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:richminime/constants/api.dart';

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
  static Future<financeInfoModel?> getExchangeRate() async {
    print('들어왔어염');

    final url = Uri.parse(
        'https://ecos.bok.or.kr/api/KeyStatisticList/DR84EM8D125149QBK68A/json/kr/2/2');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print('응답들어왔어염');

        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        print(responseBody.toString());
        // "row" 값을 추출하고 출력
        final row = responseBody['KeyStatisticList']['row'][0];
        print(row.toString());
        final exchangeRate = financeInfoModel.fromJson(row);
        return exchangeRate;
      }
    } catch (e) {
      print('에러 발생: $e');
      return null;
    }
    return null;
  }

  static Future<financeInfoModel?> getInterestRate() async {
    print('들어왔어염');

    final url = Uri.parse(
        'https://ecos.bok.or.kr/api/KeyStatisticList/DR84EM8D125149QBK68A/json/kr/51/51');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print('응답들어왔어염');

        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        print(responseBody.toString());
        // "row" 값을 추출하고 출력
        final row = responseBody['KeyStatisticList']['row'][0];
        print(row.toString());
        final exchangeRate = financeInfoModel.fromJson(row);
        return exchangeRate;
      }
    } catch (e) {
      print('에러 발생: $e');
      return null;
    }
    return null;
  }
}
