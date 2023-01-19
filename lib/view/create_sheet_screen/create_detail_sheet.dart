import 'package:flutter/material.dart';

class CreateDetailSheet extends StatefulWidget {
  const CreateDetailSheet({super.key});

  @override
  State<CreateDetailSheet> createState() => _CreateDetailSheetState();
}

class _CreateDetailSheetState extends State<CreateDetailSheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Create your text field here!'),
    );
  }
}
