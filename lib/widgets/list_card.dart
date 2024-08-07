import 'package:flutter/material.dart';
import 'package:personal_detail/custom_route.dart';
import 'package:personal_detail/model/main_model.dart';
import 'package:personal_detail/providers/user_provider.dart';
import 'package:personal_detail/screen/personal_detail.dart';
import 'package:provider/provider.dart';

class ListItemCard extends StatelessWidget {
  const ListItemCard(this.mainModel, {super.key});
  final MainModel mainModel;
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
                MyRoute(context, const PersonalDetail()).navigate();
              },
            ),
          ),
        ),
      ],
    );
  }
}
