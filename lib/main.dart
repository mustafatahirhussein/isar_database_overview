import 'package:exploring_isar_db/all_books.dart';
import 'package:exploring_isar_db/isar_db/books.dart';
import 'package:exploring_isar_db/provider/book_provider.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'isar_db/constants.dart';

Future<dynamic> isarConfig() async {
  final dir = await getApplicationDocumentsDirectory();

  isar = Isar.open([BooksSchema], inspector: true, directory: dir.path);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await isarConfig();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BookProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: true,
        home: AllBooks(),
      ),
    );
  }
}
