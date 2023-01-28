import 'package:flutter/material.dart';
import 'package:personal_detail/main.dart';
import 'package:personal_detail/providers/user_provider.dart';
import 'package:personal_detail/widgets/list_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  List<String> arratList = ['shoaib', 'sayed'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Users'),
      ),
      body: FutureBuilder(
        future:
            Provider.of<UserProvider>(context, listen: false).fetchAndSetData(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<UserProvider>(
                    builder: ((ctx, userData, ch) => userData.items.isEmpty
                        ? ch!
                        : ListView.builder(
                            itemCount: userData.items.length,
                            itemBuilder: (ctx, i) =>
                                ListItemCard(userData.items[i]),
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
          Navigator.of(context).pushNamed(MyApp.personalDetail);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
