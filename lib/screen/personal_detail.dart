import 'package:flutter/material.dart';
import 'package:personal_detail/widgets/personal_from.dart';

class PersonalDetail extends StatelessWidget {
  const PersonalDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personal Detail')),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(15),
            alignment: Alignment.center,
            child: const PersonalForm()),
      ),
    );
  }
}
