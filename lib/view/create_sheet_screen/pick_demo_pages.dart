import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/res/components/flushbar_icon.dart';
import 'package:cheat_sheet/res/typo.dart';
import 'package:flutter/material.dart';
import '../../res/components/flushbar.dart';

class PickDemoPages extends StatefulWidget {
  const PickDemoPages({super.key});

  @override
  State<PickDemoPages> createState() => _PickDemoPagesState();
}

class _PickDemoPagesState extends State<PickDemoPages> {
  static const int _count = 10;
  final List<bool> _checks = List.generate(_count, (_) => false);
  List<int> _selectedItems = [];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _selectedItems = _selectedItems.map((number) => number + 1).toList();
        },
        backgroundColor: AppColors.primary500,
        child: const Icon(Icons.arrow_forward_ios_rounded),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.008, vertical: screenWidth * 0.048),
                  child: const Regular20px(text: "กรุณาเลือกหน้าชีทตัวอย่าง"),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.036),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isPortrait ? 2 : 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 16,
                      mainAxisExtent: isPortrait ? 250 : 300,
                    ),
                    itemCount: _count,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Image.network(
                              'https://static.trueplookpanya.com/tppy/member/m_665000_667500/665461/cms/images/%E0%B9%84%E0%B8%AD%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%88%E0%B8%94%E0%B8%8A%E0%B8%B5%E0%B8%97%E0%B8%AA%E0%B8%A3%E0%B8%B8%E0%B8%9B_25.jpg'),
                          Align(
                            alignment: Alignment.topRight,
                            child: Checkbox(
                              value: _checks[index],
                              onChanged: (newvalue) {},
                            ),
                          ),
                          GestureDetector(
                            child: Container(
                              color: _checks[index] ? Colors.transparent : Colors.transparent,
                            ),
                            onTap: () {
                              setState(() {
                                if (_checks.where((check) => check).length >= 5 && !_checks[index]) {
                                  FlushbarPopup.errorFlushbar(context, FlushbarIcon.errorIcon, "เลือกได้สูงสุด 5 หน้า");
                                  return;
                                }
                                _checks[index] = !_checks[index];
                                if (_selectedItems.contains(index)) {
                                  _selectedItems.remove(index);
                                } else {
                                  _selectedItems.add(index);
                                }
                              });
                            },
                          ),
                        ],
                      );
                    },
                    padding: EdgeInsets.only(bottom: screenWidth * 0.048),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
