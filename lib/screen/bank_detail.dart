import 'package:flutter/material.dart';
import 'package:personal_detail/model/bank_data.dart';
import 'package:personal_detail/widgets/bank_form.dart';

class BankDetails extends StatelessWidget {
  const BankDetails(this._bankData, {super.key});

  final Function(BankData bankData, BuildContext context) _bankData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Details'),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(15),
            alignment: Alignment.center,
            child: BankForm(_bankData, context)),
      ),
    );
  }
}
