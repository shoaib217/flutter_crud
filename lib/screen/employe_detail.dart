import 'package:flutter/material.dart';
import 'package:personal_detail/widgets/employee_form.dart';
import '../model/employee_data.dart';

class EmployeDetail extends StatelessWidget {
  const EmployeDetail(this.employeData, {super.key});
  final Function(EmployeeData employeeData) employeData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Employee Detail')),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(15),
            alignment: Alignment.center,
            child: EmployeForm(employeData)),
      ),
    );
  }
}
