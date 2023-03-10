import 'dart:math';

import 'package:flutter/material.dart';
import 'package:personal_detail/helper/db_helper.dart';
import 'package:personal_detail/model/bank_data.dart';
import 'package:personal_detail/model/employee_data.dart';
import 'package:personal_detail/model/main_model.dart';
import 'package:personal_detail/model/personal_data.dart';
import 'package:personal_detail/widgets/personal_from.dart';

class UserProvider with ChangeNotifier {
  List<MainModel> _items = [];

  List<MainModel> get items {
    return [..._items];
  }

  late MainModel mainModel;

  bool editMode = false;

  Future<void> addUser(PersonData personData, EmployeeData employeeData,
      BankData bankData) async {
    notifyListeners();
    print("id---${personData.id}");
    var gender = 'male';
    if (personData.gender == Gender.female) {
      gender = 'female';
    }
    if (editMode) {
      DBHelper.update({
        'name': personData.name,
        'email': personData.email,
        'mobile': personData.mobile,
        'gender': gender,
        'empName': employeeData.empName,
        'empEmail': employeeData.empEmail,
        'designation': employeeData.designation,
        'accountNo': bankData.accountNo,
        'accountHolderName': bankData.accountHolderName,
        'ifscCode': bankData.ifscCode,
        'bankName': bankData.bankName,
      }, personData.id);
    } else {
      DBHelper.insert({
        'id': personData.id,
        'name': personData.name,
        'email': personData.email,
        'mobile': personData.mobile,
        'gender': gender,
        'empName': employeeData.empName,
        'empEmail': employeeData.empEmail,
        'designation': employeeData.designation,
        'accountNo': bankData.accountNo,
        'accountHolderName': bankData.accountHolderName,
        'ifscCode': bankData.ifscCode,
        'bankName': bankData.bankName,
      });
    }
  }

  Future<void> fetchAndSetData() async {
    final dataList = await DBHelper.getData();
    _items = dataList
        .map(
          (item) => MainModel(
            PersonData(
                id: item['id'],
                name: item['name'],
                email: item['email'],
                mobile: item['mobile'],
                gender: item['gender'] == 'male' ? Gender.male : Gender.female),
            EmployeeData(
              item['empName'],
              item['empEmail'],
              item['designation'],
            ),
            BankData(
              item['accountNo'],
              item['accountHolderName'],
              item['ifscCode'],
              item['bankName'],
            ),
          ),
        )
        .toList();
    print("object - $items");
    notifyListeners();
  }

  void setForEdit(bool value) {
    editMode = value;
  }

  void setDataForEdit(MainModel maindata) {
    mainModel = maindata;
  }

  Future<void> deleteUser(String id) async {
    await DBHelper.deleteUser(id);
    _items.removeWhere((element) => element.personData.id == id);
    notifyListeners();
  }
}
