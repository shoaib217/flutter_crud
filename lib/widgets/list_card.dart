import 'package:flutter/material.dart';
import 'package:personal_detail/main.dart';
import 'package:personal_detail/model/main_model.dart';
import 'package:personal_detail/providers/user_provider.dart';
import 'package:personal_detail/screen/personal_detail.dart';
import 'package:provider/provider.dart';

class ListItemCard extends StatelessWidget {
  ListItemCard(this.mainModel, {super.key});
  MainModel mainModel;
  @override
  Widget build(BuildContext context) {
    var _personData = mainModel.personData;
    return Row(
      children: [
        Expanded(
          child: ListTile(
            title: Text(
              _personData.name,
              style: const TextStyle(fontSize: 24),
            ),
            subtitle:
                Text(_personData.email, style: const TextStyle(fontSize: 16)),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              color: Colors.amber,
              onPressed: () {
                Provider.of<UserProvider>(context, listen: false)
                    .setForEdit(true);
                Provider.of<UserProvider>(context, listen: false)
                    .setDataForEdit(mainModel);
                Navigator.of(context).pushNamed(MyApp.personalDetail);
              },
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 10),
          child: IconButton(
            icon: const Icon(Icons.delete),
            color: Colors.red,
            onPressed: () {
              Provider.of<UserProvider>(context, listen: false)
                  .deleteUser(_personData.id);
            },
          ),
        )
      ],
    );
  }
}
