import 'package:isar/isar.dart';
part 'books.g.dart';

@Collection()
class Books {
  final id = Isar.autoIncrement;

  String? title, author, publishYear;
}
