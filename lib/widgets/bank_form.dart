import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_detail/screen/home_screen.dart';
import '../model/bank_data.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class BankForm extends StatefulWidget {
  const BankForm(this._bankData, this.ctx, {super.key});
  final Function(BankData bankData, BuildContext context) _bankData;
  final BuildContext ctx;

  @override
  State<BankForm> createState() => _BankFormState();
}

class _BankFormState extends State<BankForm> {
  var _formKey = GlobalKey<FormState>();
  var _accHolderName = TextEditingController();
  var _accNumber = TextEditingController();
  var _ifsc = TextEditingController();
  var _bankName = TextEditingController();

  @override
  void initState() {
    super.initState();
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    if (userProvider.editMode) {
      _accHolderName.text = userProvider.mainModel.bankData.accountHolderName;
      _accNumber.text = userProvider.mainModel.bankData.accountNo;
      _ifsc.text = userProvider.mainModel.bankData.ifscCode;
      _bankName.text = userProvider.mainModel.bankData.bankName;
    }
  }

  void _saveBankData() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      widget._bankData(
          BankData(
              _accNumber.text, _accHolderName.text, _ifsc.text, _bankName.text),
          context);

      Navigator.of(widget.ctx).pushAndRemoveUntil(
          MaterialPageRoute(builder: (ctx) => HomeScreen()), (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _accHolderName,
            decoration:
                const InputDecoration(hintText: 'Enter Account Holder Name'),
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value.toString().trim().isEmpty) {
                return 'Please Enter Account Holder Name';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            maxLength: 17,
            controller: _accNumber,
            decoration: const InputDecoration(hintText: 'Enter Account Number'),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value.toString().trim().isEmpty) {
                return 'Please Enter Account Number';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            maxLength: 11,
            textCapitalization: TextCapitalization.characters,
            controller: _ifsc,
            decoration: const InputDecoration(hintText: 'Enter IFSC Code'),
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value.toString().trim().isEmpty) {
                return 'Please Enter IFSC Code';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            textCapitalization: TextCapitalization.characters,
            controller: _bankName,
            decoration: const InputDecoration(hintText: 'Enter Bank Name'),
            textInputAction: TextInputAction.done,
            validator: (value) {
              if (value.toString().trim().isEmpty) {
                return 'Please Enter Bank Name';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: _saveBankData,
            child: Text(
              userProvider.editMode ? 'Update' : 'Save',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}
