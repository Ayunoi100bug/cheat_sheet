import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/res/components/sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../utils/routes/routes.gr.dart';
import '../../res/colors.dart';
import '../../res/typo.dart';

class SearchingSheet extends StatefulWidget {
  const SearchingSheet({super.key});

  @override
  State<SearchingSheet> createState() => _SearchingSheetState();
}

class _SearchingSheetState extends State<SearchingSheet> {
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var sortStream = _firestore.collection("sheet").snapshots();

    if (sort == 'rating') {
      setState(
        () {
          sortStream = _firestore.collection("sheet").orderBy('rating', descending: true).snapshots();
        },
      );
    } else if (sort == 'priceMore') {
      setState(
        () {
          sortStream = _firestore.collection("sheet").orderBy('price', descending: true).snapshots();
        },
      );
    } else if (sort == 'priceLess') {
      setState(
        () {
          sortStream = _firestore.collection("sheet").orderBy('price', descending: false).snapshots();
        },
      );
    } else if (sort == 'typeFree') {
      setState(
        () {
          sortStream = _firestore.collection("sheet").where('sheetTypeFree', isEqualTo: true).snapshots();
        },
      );
    } else if (sort == 'typeBuy') {
      setState(
        () {
          sortStream = _firestore.collection("sheet").where('sheetTypeFree', isEqualTo: false).snapshots();
        },
      );
    } else if (sort == 'sheetNew') {
      setState(
        () {
          sortStream = _firestore.collection("sheet").orderBy('timestamp', descending: true).snapshots();
        },
      );
    } else if (sort == 'sheetOld') {
      setState(
        () {
          sortStream = _firestore.collection("sheet").orderBy('timestamp', descending: false).snapshots();
        },
      );
    }

    return StreamBuilder<QuerySnapshot>(
      stream: sortStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final int documentCount = snapshot.data!.docs.length;
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
                      autofocus: true,
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
                            _sortSheet(context);
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
                      itemCount: documentCount,
                      itemBuilder: (context, index) {
                        var sheet = snapshot.data?.docs[index];
                        return StreamBuilder<DocumentSnapshot>(
                          stream: _firestore.collection("users").doc(sheet?["authorId"]).snapshots(),
                          builder: (context, userSnapshot) {
                            if (!userSnapshot.hasData) {
                              return Container();
                            } else if (userSnapshot.connectionState == ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return Sheet(
                              rating: sheet?["rating"],
                              sheetCoverImage: sheet?["sheetCoverImage"],
                              authorImage: userSnapshot.data?["profileImage"],
                              title: sheet?["sheetName"],
                              priceSheet: sheet?["price"],
                              username: userSnapshot.data?["username"],
                              sheetId: sheet?["sid"],
                            );
                          },
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
      },
    );
  }
}

String? sort;

void _sortSheet(context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
      top: Radius.circular(10),
    )),
    builder: (BuildContext context) {
      return SizedBox(
        height: isPortrait ? screenHeight * 0.48 : screenHeight * 0.6,
        child: Padding(
          padding: EdgeInsets.only(
              top: screenWidth * 0.040,
              bottom: isPortrait ? screenWidth * 0.040 : screenWidth * 0.012,
              left: screenWidth * 0.044,
              right: screenWidth * 0.044),
          child: SingleChildScrollView(
            child: Column(
              children: const [
                AllSort(),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class AllSort extends StatefulWidget {
  const AllSort({super.key});

  @override
  State<AllSort> createState() => _AllSortState();
}

class _AllSortState extends State<AllSort> {
  @override
  final List<String> title = <String>[
    'คะแนนรีวิวที่ดีที่สุด',
    'ราคา มากไปน้อย',
    'ราคา น้อยไปมาก',
    'ประเภท ชีทฟรี',
    'ประเภท ชีทเสียเงิน',
    'ชีทใหม่ไปเก่า',
    'ชีทเก่าไปใหม่'
  ];

  final List<String> value = <String>['rating', 'priceMore', 'priceLess', 'typeFree', 'typeBuy', 'sheetNew', 'sheetOld'];

  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 7,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text('${title[index]}'),
          leading: Radio(
            value: '${value[index]}',
            groupValue: sort,
            onChanged: (value) {
              setState(
                () {
                  sort = value.toString();
                  AutoRouter.of(context).popAndPush(const SearchingSheetRoute());
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        );
      },
    );
  }
}
