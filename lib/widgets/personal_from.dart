import 'dart:math';

import 'package:flutter/material.dart';
import 'package:personal_detail/custom_route.dart';
import 'package:personal_detail/model/personal_data.dart';
import 'package:personal_detail/providers/user_provider.dart';
import 'package:personal_detail/screen/employe_detail.dart';
import 'package:provider/provider.dart';

enum Gender { male, female }

class PersonalForm extends StatefulWidget {
  const PersonalForm({super.key});

  @override
  State<PersonalForm> createState() => _PersonalFormState();
}

class _PersonalFormState extends State<PersonalForm> {
  var _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Gender? _gender = Gender.male;
  @override
  void initState() {
    super.initState();
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    if (userProvider.editMode) {
      _nameController.text = userProvider.mainModel.personData.name;
      _emailController.text = userProvider.mainModel.personData.email;
      _mobileController.text = userProvider.mainModel.personData.mobile;
      _gender = userProvider.mainModel.personData.gender;
    }
  }

  void _savedDetail() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      print('validated');
      Provider.of<UserProvider>(context, listen: false).personData = PersonData(
          id: Provider.of<UserProvider>(context, listen: false).editMode
              ? Provider.of<UserProvider>(context, listen: false)
                  .mainModel
                  .personData
                  .id
              : DateTime.now().toString(),
          name: _nameController.text,
          email: _emailController.text,
          mobile: _mobileController.text,
          gender: _gender!,
          color: Colors.primaries[Random().nextInt(Colors.primaries.length)]
              .shade200.value);
      MyRoute(context, const EmployeDetail()).navigate();
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
            decoration: const InputDecoration(hintText: 'Enter Your Name'),
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value.toString().trim().isEmpty) {
                return 'Please Enter Name';
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
                const InputDecoration(hintText: 'Enter Your Email Address'),
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
            height: 20,
          ),
          TextFormField(
            maxLength: 10,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _mobileController,
            decoration:
                const InputDecoration(hintText: 'Enter Your Mobile Number'),
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.done,
            validator: (value) {
              if (value.toString().trim().isEmpty) {
                return 'Please Enter Mobile Number.';
              } else if (value!.length < 10) {
                return 'Please Enter Valid Mobile Number.';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            'Gender',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Expanded(
                child: ListTile(
                  title: const Text('Male'),
                  leading: Radio<Gender>(
                    value: Gender.male,
                    groupValue: _gender,
                    onChanged: (Gender? value) {
                      print("test0 -- $value");
                      setState(() {
                        _gender = value;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: const Text('Female'),
                  leading: Radio<Gender>(
                    value: Gender.female,
                    groupValue: _gender,
                    onChanged: (Gender? value) {
                      print("test -- $value");
                      setState(() {
                        _gender = value;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 70,
          ),
          ElevatedButton(
            onPressed: _savedDetail,
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
