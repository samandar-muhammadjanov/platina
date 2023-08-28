import 'dart:convert';

List<Currency> currencyFromJson(String str) =>
    List<Currency>.from(json.decode(str).map((x) => Currency.fromJson(x)));

String currencyToJson(List<Currency> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Currency {
  int id;
  String code;
  String ccy;
  String ccyNmRu;
  String ccyNmUz;
  String ccyNmUzc;
  String ccyNmEn;
  String nominal;
  String rate;
  String diff;
  Date date;

  Currency({
    required this.id,
    required this.code,
    required this.ccy,
    required this.ccyNmRu,
    required this.ccyNmUz,
    required this.ccyNmUzc,
    required this.ccyNmEn,
    required this.nominal,
    required this.rate,
    required this.diff,
    required this.date,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        id: json["id"],
        code: json["Code"],
        ccy: json["Ccy"],
        ccyNmRu: json["CcyNm_RU"],
        ccyNmUz: json["CcyNm_UZ"],
        ccyNmUzc: json["CcyNm_UZC"],
        ccyNmEn: json["CcyNm_EN"],
        nominal: json["Nominal"],
        rate: json["Rate"],
        diff: json["Diff"],
        date: dateValues.map[json["Date"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Code": code,
        "Ccy": ccy,
        "CcyNm_RU": ccyNmRu,
        "CcyNm_UZ": ccyNmUz,
        "CcyNm_UZC": ccyNmUzc,
        "CcyNm_EN": ccyNmEn,
        "Nominal": nominal,
        "Rate": rate,
        "Diff": diff,
        "Date": dateValues.reverse[date],
      };
}

enum Date { THE_28082023 }

final dateValues = EnumValues({"28.08.2023": Date.THE_28082023});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
