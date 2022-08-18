import 'package:exploring_isar_db/isar_db/books.dart';
import 'package:exploring_isar_db/isar_db/constants.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

class BookProvider extends ChangeNotifier {
  List<Books> _books = [];

  List<Books> get books => _books;

  BookProvider() {
    init();
  }

  init() async {
    var i = await isar;

    await i.txn(() async {
      final allBooks = i.books;
      _books = await allBooks.where().findAll();
      notifyListeners();
    });
  }

  dynamic addNew() async {
    var i = await isar;

    var data = Books()
      ..title = "Peer-e-Kamil"
      ..author = "Umera Ahmed"
      ..publishYear = "2017";

    i.writeTxn(() async {
      int id = await i.books.put(data);

      _books.add(data);
      notifyListeners();
    });
  }

  dynamic removeItem(Books b) async {
    var data = await isar;

    await data.writeTxn(() async {
      bool deleted = await data.books.delete(b.id);

      if (deleted) {
        _books.remove(b);
        notifyListeners();
      }
      else {
        print("else");
      }
    });
  }
}
