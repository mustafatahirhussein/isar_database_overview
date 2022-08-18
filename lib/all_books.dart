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
        //   child: FutureBuilder<List<Books>>(
        //     future: provider.showAllBooks(),
        //     builder: (_, s) => s.connectionState == ConnectionState.done ? {
        //     if (s.hasData) {
        //       if (s.data.isEmpty) {
        // return Center(
        // child: Text(
        // 'No Words history',
        // style: noDef,
        // ),
        // );
        // }
        //
        //       return buil
        //
        // }
        //     } : const CircularProgressIndicator(),
        //   ),

        // child: FutureBuilder<List<Books>>(
        //   future: provider.showAllBooks(),
        //   builder: (context, s) {
        //     if (s.hasData) {
        //       if (s.data!.isEmpty) {
        //         return const Center(
        //           child: Text(
        //             'No Books',
        //           ),
        //         );
        //       }
        //
        //       return buildView(context, s);
        //     }
        //     return const Center(
        //       child: CircularProgressIndicator(),
        //     );
        //   },
        // ),

        child: buildView(context),


      ),
      floatingActionButton: FloatingActionButton(
        child: Text("add"),
        onPressed: () => provider.addNew(),
      ),
    );
  }

  dynamic buildView(BuildContext context) {
    var p = context.watch<BookProvider>();

    // return ListView.builder(
    //   itemCount: books.data!.length,
    //   itemBuilder: (_, i) {
    //     var r = books.data![i];
    //
    //     return ListTile(
    //       title: Text(r.title!),
    //       subtitle: Text(r.author!),
    //       trailing: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           Text(r.publishYear!),
    //           Expanded(
    //             child: ElevatedButton(
    //                 onPressed: () {
    //                   books.data!.removeAt(i);
    //                   p.removeItem(i);
    //                 },
    //                 child: Text("Del")),
    //           )
    //         ],
    //       ),
    //     );
    //   },
    // );

    return p.books.isEmpty ? const Center(child: Text("No books!!"),) : ListView(
      shrinkWrap: true,
      children: p.books.map((e) => ListTile(
        title: Text(e.title!),
        subtitle: Text(e.author!),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(e.publishYear!),
            Expanded(
              child: ElevatedButton(
                  onPressed: () {
                    p.removeItem(e);
                  },
                  child: Text("Del")),
            )
          ],
        ),
      ),).toList(),
    );
  }
}
