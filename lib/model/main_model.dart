import 'package:personal_detail/model/bank_data.dart';
import 'package:personal_detail/model/employee_data.dart';
import 'package:personal_detail/model/personal_data.dart';

class MainModel {
  PersonData personData;
  EmployeeData employeeData;
  BankData bankData;

  MainModel(this.personData, this.employeeData, this.bankData);
}
