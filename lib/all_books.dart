import 'package:exploring_isar_db/isar_db/books.dart';
import 'package:exploring_isar_db/provider/book_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllBooks extends StatelessWidget {
  const AllBooks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var provider = context.watch<BookProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Exploring Isar DB"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: FutureBuilder<List<Books>>(
          future: provider.showAllBooks(),
          builder: (_, s) => s.connectionState == ConnectionState.done ? buildView(context, s) : const CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text("add"),
        onPressed: () => provider.addNew(),
      ),
    );
  }

  dynamic buildView(BuildContext context, AsyncSnapshot<List<Books>> books) {

    var p = context.watch<BookProvider>();

    // return ListView(
    //   children: books.data!.map((e) {
    //     return Card(
    //       child: Text(e.author!),
    //     );
    //   }).toList(),
    // );

    return ListView.builder(
      itemCount: books.data!.length,
      itemBuilder: (_, i) {

        var r = books.data![i];

        return Dismissible(
          key: UniqueKey(),
          onDismissed: (_) {
            books.data!.removeAt(i);
            p.removeItem(i);
          },
          child: ListTile(
            title: Text(r.title!),
            subtitle: Text(r.author!),
            trailing: Text(r.publishYear!),
          ),
        );
      },
    );

  }
}
