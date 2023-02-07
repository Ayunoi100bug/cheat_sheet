import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/res/button.dart';
import 'package:cheat_sheet/res/colors.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:cheat_sheet/view_model/file_passer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../data/network/pdf_api.dart';

class CreateSheetScreen extends StatefulWidget {
  const CreateSheetScreen({super.key});

  @override
  State<CreateSheetScreen> createState() => _CreateSheetScreenState();
}

class _CreateSheetScreenState extends State<CreateSheetScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Column(
          children: <Widget>[
            SizedBox(
              width: screenWidth,
              height: screenWidth < 420
                  ? constraints.maxHeight * 0.5
                  : constraints.maxHeight * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    FontAwesomeIcons.download,
                    size: screenWidth < 480
                        ? screenHeight * 0.1
                        : screenHeight * 0.2,
                    color: AppColors.black400,
                  ),
                  SizedBox(
                    height: screenHeight * 0.008,
                  ),
                  PrimaryButton(
                      text: 'นำเข้าชีท',
                      onPressed: () async {
                        final file = await PDFApi.pickFile(context);
                        if (file == null) return;
                        Provider.of<FilePasser>(context, listen: false)
                            .setFile(file);
                        AutoRouter.of(context).push(ViewImportSheetRoute());
                      }),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
