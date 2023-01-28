import 'package:flutter/material.dart';
import 'package:personal_detail/model/personal_data.dart';
import 'package:personal_detail/widgets/personal_from.dart';

class PersonalDetail extends StatelessWidget {
  const PersonalDetail(this._persondata, {super.key});
  final Function(PersonData personData) _persondata;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personal Detail')),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(15),
            alignment: Alignment.center,
            child: PersonalForm(_persondata)),
      ),
    );
  }
}
