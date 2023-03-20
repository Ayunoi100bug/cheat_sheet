import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../res/components/sheet.dart';
import '../../../res/gap_dimension.dart';
import '../../../res/typo.dart';

class MySheet extends StatefulWidget {
  const MySheet({super.key});

  @override
  State<MySheet> createState() => _MySheetState();
}

class _MySheetState extends State<MySheet> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final TextEditingController _searchController = TextEditingController();
  bool isSort = false;
  bool isFree = false;
  late String isActive = "";
  late Future resultLoaded;
  List _sheetResult = [];
  List _authorResult = [];
  List _resultList = [];
  List _sheetList = [];
  List _authorList = [];

  String? selectedSortBy;
  String? selectedType;

  final Map<String, String> sortBy = {
    'rating': 'เรตติ้ง',
    'timestamp': 'ระยะเวลา',
  };

  @override
  void initState() {
    super.initState();
    selectedSortBy = sortBy.keys.first;
    // isActive = sortBy.keys.first;
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

      _sheetList = sheetResult;
      _authorList = authorResult;

      for (int i = 0; i < _sheetList.length; i++) {
        Map combined = {..._sheetList[i], ..._authorList[i].data()};
        _resultList.add(combined);
      }
      if (selectedSortBy != null && isSort == true) {
        _resultList.sort((a, b) => -(a[selectedSortBy] ?? '').compareTo(b[selectedSortBy] ?? ''));
      }
    });
  }

  getSheetSnapshot() async {
    var sheetData = await _firestore.collection('sheet').where('authorId', isEqualTo: _auth.currentUser!.uid).get();
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
      searchResultsList();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection("sheet").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.76,
                        height: isPortrait ? screenWidth * 0.12 : screenWidth * 0.06,
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
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          height: 44,
                          width: 44, // color: Colors.amber,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.black500),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.sort_rounded,
                              size: 28,
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(10),
                                )),
                                builder: (BuildContext context) {
                                  return SingleChildScrollView(
                                    child: Container(
                                      padding: EdgeInsets.only(top: screenWidth * 0.040),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(bottom: screenWidth * 0.03),
                                            child: const Regular16px(
                                              text: 'จัดเรียงโดย',
                                            ),
                                          ),
                                          InkWell(
                                            child: Container(
                                              padding: EdgeInsets.all(screenWidth * GapDimension.w0_032),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  const Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Regular16px(
                                                      text: "เรตติ้ง",
                                                    ),
                                                  ),
                                                  if (isActive == 'rating') ...[
                                                    Icon(Icons.check, color: AppColors.primary800, size: screenWidth * 0.04),
                                                  ],
                                                ],
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                _resultList.sort((a, b) => -(a[selectedSortBy] ?? '').compareTo(b[selectedSortBy] ?? ''));
                                                isSort = true;
                                                isActive = 'rating';
                                              });
                                              Navigator.of(context).pop();
                                              AutoRouter.of(context).popUntilRoot();
                                            },
                                          ),
                                          Container(
                                            width: screenWidth * 0.95,
                                            height: screenWidth * 0.002,
                                            color: AppColors.black400,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenWidth * 0.03,
                  ),
                  GridView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isPortrait ? 3 : 5,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 12,
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
                  ),
                ],
              ),
            ),
          );
        });
  }
}
