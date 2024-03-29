class Tag {
  String tagName;
  List<String> sheetInTagList = [];

  Tag({
    required this.tagName,
    required this.sheetInTagList, required Null Function() onPressed,
  });

  Tag.fromJson(Map<String, dynamic> json)
      : tagName = json['tagName'],
        sheetInTagList = json['sheetInTagList'];

  Map<String, dynamic> toJson() => {
        'tagName': tagName,
        'sheetInTagList': sheetInTagList,
      };
}
