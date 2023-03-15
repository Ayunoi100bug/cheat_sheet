import 'package:cheat_sheet/res/components/sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '../../res/colors.dart';
import '../../res/typo.dart';

class SearchingSheet extends StatefulWidget {
  const SearchingSheet({super.key});

  @override
  State<SearchingSheet> createState() => _SearchingSheetState();
}

class _SearchingSheetState extends State<SearchingSheet> {
  final _firestore = FirebaseFirestore.instance;

  final TextEditingController _searchController = TextEditingController();
  bool isSort = false;
  bool isFree = false;
  late Future resultLoaded;
  List _sheetResult = [];
  List _authorResult = [];
  List _resultList = [];
  List __dataList = [];
  List _sheetList = [];
  List _authorList = [];

  String? selectedSortBy;
  String? selectedType;

  final Map<String, String> sortBy = {
    'rating': 'เรตติ้ง',
    'timestamp': 'ระยะเวลา',
  };

  final Map<String, String> type = {
    'all': 'ทั้งหมด',
    'true': 'ฟรี',
    'false': 'เสียเงิน',
  };

  @override
  void initState() {
    super.initState();
    selectedSortBy = sortBy.keys.first;
    selectedType = type.keys.first;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultLoaded = getSheetSnapshot();
  }

  _onSearchChanged() {
    searchResultsList();
  }

  searchResultsList() {
    var sheetResult = [];
    var authorResult = [];

    if (_searchController.text != "") {
      for (var sheetSnapshot in _sheetResult) {
        var sheetName = sheetSnapshot['sheetName'].toLowerCase();
        if (sheetName.contains(_searchController.text.toLowerCase())) {
          sheetResult.add(sheetSnapshot);
          for (var userSnapshot in _authorResult) {
            if (userSnapshot['uid'] == sheetSnapshot['authorId']) {
              authorResult.add(userSnapshot);
              break;
            }
          }
        }
      }
    } else {
      sheetResult = List.from(_sheetResult);
      authorResult = List.from(_authorResult);
    }
    setState(() {
      _resultList = [];
      __dataList = [];
      _sheetList = sheetResult;
      _authorList = authorResult;

      for (int i = 0; i < _sheetList.length; i++) {
        Map combined = {..._sheetList[i], ..._authorList[i].data()};
        _resultList.add(combined);
        __dataList.add(combined);
      }
      if (selectedSortBy != null && isSort == true) {
        __dataList.sort((a, b) => -(a[selectedSortBy] ?? '').compareTo(b[selectedSortBy] ?? ''));
      }
      if (isFree == true) {
        _resultList = __dataList.where((list) {
          if (selectedType == 'all') {
            return list['sheetTypeFree'] == true || list['sheetTypeFree'] == false;
          }
          return list['sheetTypeFree'].toString() == selectedType;
        }).toList();
      }
    });
  }

  getSheetSnapshot() async {
    var sheetData = await _firestore.collection('sheet').get();
    var authorData = await _firestore.collection('users').get();
    setState(() {
      _sheetResult = sheetData.docs.map((doc) => doc.data()).toList();
      for (var sheetData in sheetData.docs) {
        for (var userSnapshot in authorData.docs) {
          if (userSnapshot['uid'] == sheetData['authorId']) {
            _authorResult.add(userSnapshot);
          }
        }
      }
    });
    searchResultsList();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenWidth * 0.02),
                child: TextField(
                  controller: _searchController,
                  cursorColor: AppColors.black900,
                  decoration: InputDecoration(
                    isDense: true,
                    fillColor: AppColors.black200,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50), borderSide: const BorderSide(width: 1, color: AppColors.primary800)),
                    hintText: 'Search',
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50), borderSide: const BorderSide(width: 1, color: AppColors.primary800)),
                    hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
                    prefixIcon: const SizedBox(
                      width: 18,
                      child: Icon(
                        Icons.search,
                        color: AppColors.primary800,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    _onSearchChanged();
                  },
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Container(
                padding: EdgeInsets.only(left: screenWidth * 0.04, right: screenWidth * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Medium20px(text: 'ผลลัพธ์การค้นหา'),
                    InkWell(
                      child: const Icon(
                        Icons.filter_alt_outlined,
                        color: AppColors.tertiary600,
                        size: 30,
                      ),
                      onTap: () {
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Regular20px(
                                text: 'ตัวกรองการค้นหา',
                                fontWeight: FontWeight.w500,
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Regular14px(
                                        text: 'จัดเรียงตาม',
                                        color: AppColors.black600,
                                      ),
                                      SizedBox(
                                        width: 160,
                                        child: StatefulBuilder(builder: (context, dropDownState) {
                                          return DropdownButtonHideUnderline(
                                              child: DropdownButton2(
                                            hint: Regular16px(
                                              text: selectedSortBy ?? sortBy.values.first,
                                              activateOverflow: true,
                                            ),
                                            items: sortBy.entries
                                                .map((item) => DropdownMenuItem(
                                                      value: item.key,
                                                      child: Regular16px(
                                                        text: item.value,
                                                        activateOverflow: true,
                                                      ),
                                                    ))
                                                .toList(),
                                            value: selectedSortBy,
                                            onChanged: (value) {
                                              dropDownState(() {
                                                selectedSortBy = value as String;
                                              });
                                            },
                                          ));
                                        }),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Regular14px(
                                        text: 'ประเภท',
                                        color: AppColors.black600,
                                      ),
                                      SizedBox(
                                        width: 160,
                                        child: StatefulBuilder(builder: (context, dropDownState) {
                                          return DropdownButtonHideUnderline(
                                              child: DropdownButton2(
                                            hint: Regular16px(
                                              text: selectedType ?? type.values.first,
                                              activateOverflow: true,
                                            ),
                                            items: type.entries
                                                .map((item) => DropdownMenuItem(
                                                    value: item.key,
                                                    child: Regular16px(
                                                      text: item.value,
                                                      activateOverflow: true,
                                                    )))
                                                .toList(),
                                            value: selectedType,
                                            onChanged: (value) {
                                              dropDownState(() {
                                                selectedType = value as String;
                                              });
                                            },
                                          ));
                                        }),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('ยกเลิก'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text('นำไปใช้'),
                                  onPressed: () {
                                    setState(() {
                                      __dataList.sort((a, b) => -(a[selectedSortBy] ?? '').compareTo(b[selectedSortBy] ?? ''));
                                      _resultList = __dataList.where((list) {
                                        if (selectedType == 'all') {
                                          return list['sheetTypeFree'] == true || list['sheetTypeFree'] == false;
                                        }
                                        return list['sheetTypeFree'].toString() == selectedType;
                                      }).toList();
                                      isFree = true;
                                      isSort = true;
                                      Navigator.of(context).pop();
                                    });
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.038),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isPortrait ? 3 : 5,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 16,
                    mainAxisExtent: isPortrait ? 200 : 250,
                  ),
                  itemCount: _resultList.length,
                  itemBuilder: (context, index) {
                    return Sheet(
                      rating: _resultList[index]['rating'].toDouble() ?? 0,
                      sheetCoverImage: _resultList[index]['sheetCoverImage'],
                      authorImage: _resultList[index]['profileImage'] ?? "",
                      title: _resultList[index]['sheetName'] ?? "",
                      priceSheet: _resultList[index]['price'] ?? 0,
                      username: _resultList[index]['username'] ?? "",
                      sheetId: _resultList[index]['sid'] ?? "",
                    );
                  },
                  padding: const EdgeInsets.only(bottom: 8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
