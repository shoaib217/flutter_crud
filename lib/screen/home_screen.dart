import 'dart:math';

import 'package:flutter/material.dart';
import 'package:personal_detail/custom_route.dart';
import 'package:personal_detail/model/main_model.dart';
import 'package:personal_detail/providers/user_provider.dart';
import 'package:personal_detail/screen/personal_detail.dart';
import 'package:personal_detail/widgets/list_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crud Operation'),
      ),
      body: FutureBuilder(
        future:
            Provider.of<UserProvider>(context, listen: false).fetchAndSetData(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<UserProvider>(
                builder: (ctx, userData, ch) =>
                    userData.items.isEmpty ? ch! : MyListView(userData.items),
                child: const Center(
                  child: Text(
                    'No User Yet!',
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<UserProvider>(context, listen: false).setForEdit(false);
          MyRoute(context, const PersonalDetail()).navigate();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MyListView extends StatelessWidget {
  const MyListView(this.items, {super.key});
  final List<MainModel> items;

  @override
  Widget build(BuildContext context) {
    print("its called");
    print("${items.length}");
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (ctx, i) => Dismissible(
        key: ValueKey<int>(items.length),
        direction: DismissDirection.endToStart,
        background: Container(
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
          padding: const EdgeInsets.only(right: 20),
          alignment: Alignment.centerRight,
          child: const Icon(Icons.delete),
        ),
        onDismissed: (direction) {
          var undoData = items[i];
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${items[i].personData.name} Removed From List"),
              action: SnackBarAction(
                  label: "UNDO",
                  onPressed: () {
                    var userProvider =
                        Provider.of<UserProvider>(context, listen: false);
                    userProvider.personData = undoData.personData;
                    userProvider.employeeData = undoData.employeeData;
                    userProvider.bankData = undoData.bankData;
                    userProvider.editMode = false;
                    userProvider.addUserToList(i);
                    userProvider.addUser();
                  }),
            ),
          );
          Provider.of<UserProvider>(context, listen: false)
              .deleteUser(items[i].personData.id);
        },
        child: Container(
          decoration: BoxDecoration(
              color: Color(items[i].personData.color),
              borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
          child: ListItemCard(items[i]),
        ),
      ),
    );
  }
}
