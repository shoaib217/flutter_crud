import 'package:flutter/material.dart';
import 'package:personal_detail/custom_route.dart';
import 'package:personal_detail/main.dart';
import 'package:personal_detail/model/employee_data.dart';
import 'package:personal_detail/screen/bank_detail.dart';
import 'package:personal_detail/widgets/bank_form.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

const List<String> designations = <String>[
  'Android Developer',
  'Web Developer',
  'Tester',
  'Business Analyst'
];

class EmployeForm extends StatefulWidget {
  EmployeForm({super.key});

  @override
  State<EmployeForm> createState() => _EmployeFormState();
}

class _EmployeFormState extends State<EmployeForm> {
  var _formKey = GlobalKey<FormState>();
  var _nameController = TextEditingController();
  final _emailController = TextEditingController();

  String dropdownValue = designations.first;

  @override
  void initState() {
    super.initState();
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    if (userProvider.editMode) {
      _nameController.text = userProvider.mainModel.employeeData.empName;
      _emailController.text = userProvider.mainModel.employeeData.empEmail;
      dropdownValue = userProvider.mainModel.employeeData.designation;
    }
  }

  void _saveEmployee() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      Provider.of<UserProvider>(context, listen: false).employeeData =
          EmployeeData(
              _nameController.text, _emailController.text, dropdownValue);

      MyRoute(context, const BankDetails()).navigate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _nameController,
            decoration: const InputDecoration(hintText: 'Enter Employee Name'),
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value.toString().trim().isEmpty) {
                return 'Please Enter Employee Name';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _emailController,
            decoration:
                const InputDecoration(hintText: 'Enter Employee Email Address'),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value.toString().trim().isEmpty) {
                return 'Please Enter Email';
              } else if (!value!.contains('@')) {
                return 'Invalid Email Address';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 50,
          ),
          const Text(
            'Designation',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          DropdownButton<String>(
            isExpanded: true,
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
              });
            },
            items: designations.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: _saveEmployee,
            child: const Text(
              'Next',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}
