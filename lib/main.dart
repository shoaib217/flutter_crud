import 'package:flutter/material.dart';
import 'package:personal_detail/model/bank_data.dart';
import 'package:personal_detail/model/employee_data.dart';
import 'package:personal_detail/model/personal_data.dart';
import 'package:personal_detail/providers/user_provider.dart';
import 'package:personal_detail/screen/bank_detail.dart';
import 'package:personal_detail/screen/employe_detail.dart';
import 'package:personal_detail/screen/personal_detail.dart';
import './screen/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  static const personalDetail = '/personal_detail';
  static const employeeDetail = '/employee_detail';
  static const bankDetail = '/bank_detail';

  late PersonData _personData;

  late EmployeeData _employeeData;

  late BankData _bankData;

  void setPersonData(PersonData data) {
    _personData = data;
    print('_personData - ${data.name}');
  }

  void setEmployeeData(EmployeeData data) {
    _employeeData = data;
  }

  void setBankData(BankData data, BuildContext ctx) {
    _bankData = data;
    Provider.of<UserProvider>(ctx, listen: false)
        .addUser(_personData, _employeeData, _bankData);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: UserProvider(),
      child: MaterialApp(
        title: 'Personal detail',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
        routes: {
          personalDetail: (ctx) => PersonalDetail(setPersonData),
          employeeDetail: (ctx) => EmployeDetail(setEmployeeData),
          bankDetail: (ctx) => BankDetails(setBankData)
        },
      ),
    );
  }
}
