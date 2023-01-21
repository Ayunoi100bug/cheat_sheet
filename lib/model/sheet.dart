class Sheets {
  String sheetName;
  String detailSheet;
  String sid;
  bool sheetTypeFree;
  int? price;
  String authorId;

  Sheets({
    required this.sheetName,
    required this.detailSheet,
    required this.sid,
    required this.sheetTypeFree,
    this.price,
    required this.authorId,
  });

  Sheets.fromJson(Map<String, dynamic> json)
      : sheetName = json['sheetName'],
        detailSheet = json['detailSheet'],
        sid = json['sid'],
        sheetTypeFree = json['sheetType'],
        price = json['price'],
        authorId = json['authorId'];

  Map<String, dynamic> toJson() => {
        'sheetName': sheetName,
        'detailSheet': detailSheet,
        'sid': sid,
        'sheetTypeFree': sheetTypeFree,
        'price': price,
        'uid': authorId,
      };
}
