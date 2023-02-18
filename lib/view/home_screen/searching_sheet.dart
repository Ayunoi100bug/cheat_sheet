import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/res/components/sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../res/colors.dart';
import '../../res/typo.dart';
import '../../utils/routes/routes.gr.dart';

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
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var sortStream = _firestore.collection("sheet").snapshots();

    if (sort == 'rating') {
      setState(
        () {},
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
                  Padding(padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenWidth * 0.02),
                    child: TextField(
                      cursorColor: AppColors.black900,
                      decoration: InputDecoration(
                        isDense: true,
                        fillColor: AppColors.black200,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50), borderSide: BorderSide(width: 1, color: AppColors.primary800)),
                        hintText: 'Search',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50), borderSide: BorderSide(width: 1, color: AppColors.primary800)),
                        hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
                        prefixIcon: Container(
                          padding: const EdgeInsets.all(15),
                          child: const Icon(
                            Icons.search,
                            color: AppColors.primary800,
                          ),
                          width: 18,
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02)),
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
                  Padding(padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02)),
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
                            if (!userSnapshot.hasData || userSnapshot.data!.data() == null) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return Sheet(
                                authorImage: userSnapshot.data?["profileImage"],
                                title: sheet?["sheetName"],
                                priceSheet: sheet?["price"],
                                username: userSnapshot.data?["username"],
                                sheetId: sheet?["sid"],
                              );
                            }
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
        height: screenHeight * 0.48,
        child: Padding(
          padding: EdgeInsets.only(
              top: screenWidth * 0.040,
              bottom: isPortrait ? screenWidth * 0.040 : screenWidth * 0.012,
              left: screenWidth * 0.044,
              right: screenWidth * 0.044),
          child: Column(
            children: const [
              AllSort(),
            ],
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
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('คะแนนรีวิวที่ดีที่สุด'),
          leading: Radio(
            value: "rating",
            groupValue: sort,
            onChanged: (value) {
              setState(
                () {
                  sort = value.toString();
                  AutoRouter.of(context).popAndPush(SearchingSheetRoute());
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        ),
        ListTile(
          title: const Text('ราคา มากไปน้อย'),
          leading: Radio(
            value: "priceMore",
            groupValue: sort,
            onChanged: (value) {
              setState(
                () {
                  sort = value.toString();
                  AutoRouter.of(context).popAndPush(SearchingSheetRoute());
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        ),
        ListTile(
          title: const Text('ราคา น้อยไปมาก'),
          leading: Radio(
            value: "priceLess",
            groupValue: sort,
            onChanged: (value) {
              setState(
                () {
                  sort = value.toString();
                  AutoRouter.of(context).popAndPush(SearchingSheetRoute());
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        ),
        ListTile(
          title: const Text('ประเภท ชีทฟรี'),
          leading: Radio(
            value: "typeFree",
            groupValue: sort,
            onChanged: (value) {
              setState(
                () {
                  sort = value.toString();
                  AutoRouter.of(context).popAndPush(SearchingSheetRoute());
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        ),
        ListTile(
          title: const Text('ประเภท ชีทเสียเงิน'),
          leading: Radio(
            value: "typeBuy",
            groupValue: sort,
            onChanged: (value) {
              setState(
                () {
                  sort = value.toString();
                  AutoRouter.of(context).popAndPush(SearchingSheetRoute());
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        ),
        ListTile(
          title: const Text('ชีทใหม่ไปเก่า'),
          leading: Radio(
            value: "sheetNew",
            groupValue: sort,
            onChanged: (value) {
              setState(
                () {
                  sort = value.toString();
                  AutoRouter.of(context).popAndPush(SearchingSheetRoute());
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        ),
        ListTile(
          title: const Text('ชีทเก่าไปใหม่'),
          leading: Radio(
            value: "sheetOld",
            groupValue: sort,
            onChanged: (value) {
              setState(
                () {
                  sort = value.toString();
                  AutoRouter.of(context).popAndPush(SearchingSheetRoute());
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
