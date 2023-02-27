import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/data/network/pdf_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pdf_render/pdf_render.dart';

import 'package:pdf_render/pdf_render_widgets.dart';

class EditSheet extends StatefulWidget {
  final String sheetId;

  const EditSheet({super.key, @PathParam() required this.sheetId});

  @override
  State<EditSheet> createState() => _EditSheetState();
}

class _EditSheetState extends State<EditSheet> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  late File file;
  late PdfDocument doc;

  void _setUp() async {
    file = await PDFApi.loadPDFFromFirebase(widget.sheetId);
    doc = await PdfDocument.openFile(file.path);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setUp();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    doc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return StreamBuilder<DocumentSnapshot>(
      stream: _firestore.collection("sheet").doc(widget.sheetId).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        Map<String, dynamic> sheetData = snapshot.data!.data() as Map<String, dynamic>;

        return StreamBuilder<DocumentSnapshot>(
          stream: _firestore.collection("users").doc(sheetData['authorId']).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> authorSnapshot) {
            if (!authorSnapshot.hasData) {
              return Container();
            } else if (authorSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            Map<String, dynamic> authorData = authorSnapshot.data!.data() as Map<String, dynamic>;
            return Scaffold(
              body: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: screenHeight * 0.55,
                      width: screenWidth,
                      child: PageView.builder(
                        itemCount: sheetData['demoPages'].length,
                        itemBuilder: (context, index) {
                          return PdfPageView(
                            pdfDocument: doc,
                            pageNumber: sheetData['demoPages'][index],
                          );
                        },
                      ),
                    ),
                    Text(
                      'olo here you fxcking edit sheet.',
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
