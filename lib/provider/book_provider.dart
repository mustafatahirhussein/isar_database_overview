import 'package:exploring_isar_db/isar_db/books.dart';
import 'package:exploring_isar_db/isar_db/constants.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

class BookProvider extends ChangeNotifier {
  Future<List<Books>> showAllBooks() async {
    var i = await isar;
    return i.books.where().findAll();
  }

  dynamic addNew() async {
    var i = await isar;

    var data = Books()
      ..title = "Aab-e-Hayat"
      ..author = "Umera Ahmed"
      ..publishYear = "2017";

    i.writeTxn(() async {
      await i.books.put(data);
    });

    showAllBooks();
    notifyListeners();
  }

  dynamic removeItem(int i) async {
    var data = await isar;

    data.writeTxn(() async {
      await data.books.delete(i);
    });
    showAllBooks();
    notifyListeners();
  }
}
