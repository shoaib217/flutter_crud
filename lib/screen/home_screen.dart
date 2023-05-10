import 'package:flutter/material.dart';
import 'package:personal_detail/custom_route.dart';
import 'package:personal_detail/providers/user_provider.dart';
import 'package:personal_detail/screen/personal_detail.dart';
import 'package:personal_detail/widgets/list_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                builder: ((ctx, userData, ch) => userData.items.isEmpty
                    ? ch!
                    : ListView.builder(
                        itemCount: userData.items.length,
                        itemBuilder: (ctx, i) => Dismissible(
                          key: ValueKey<int>(i),
                          child: ListItemCard(userData.items[i]),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            padding: const EdgeInsets.only(right: 20),
                            alignment: Alignment.centerRight,
                            color: Colors.red,
                            child: const Icon(Icons.delete),
                          ),
                          onDismissed: (direction) {
                            var undoData = userData.items[i];
                             ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("${userData.items[i].personData.name} Removed From List"),
                              action: SnackBarAction(label: "UNDO", onPressed: (){
                                var userProvider = Provider.of<UserProvider>(context,listen: false);
                                userProvider.personData = undoData.personData;
                                userProvider.employeeData = undoData.employeeData;
                                userProvider.bankData = undoData.bankData;
                                userProvider.editMode =false;
                                userProvider.addUser();
                                setState(() {});
                              }),),
                            );
                            Provider.of<UserProvider>(context, listen: false)
                                .deleteUser(userData.items[i].personData.id);
                          },
                        ),
                      )),
                child: const Center(
                  child: Text(
                    'No User Yet!',
                  ),
                )),
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
