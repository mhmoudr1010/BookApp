import 'package:book_app/data/book.dart';
import 'package:flutter/material.dart';
import './data/book_helper.dart';

class BooksTable extends StatelessWidget {
  BooksTable({super.key, required this.books, required this.isFavorite});

  final List<Book>? books;
  final bool isFavorite;
  final BookHelper helper = BookHelper();

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(3),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(2),
        3: FlexColumnWidth(1),
      },
      border: TableBorder.all(color: Colors.blueGrey),
      children: books!.map((book) {
        return TableRow(children: [
          TableCell(child: TableText(book.title)),
          TableCell(child: TableText(book.authors)),
          TableCell(child: TableText(book.publisher)),
          TableCell(
              child: IconButton(
            icon: const Icon(Icons.star),
            color: (isFavorite) ? Colors.red : Colors.amber,
            tooltip:
                (isFavorite) ? 'Remove from favourites' : 'Add to Favourites',
            onPressed: () {
              // to add favs
              if (isFavorite) {
                helper.removeFromFavouites(book, context);
              } else {
                helper.addToFavourites(book);
              }
            },
          )),
        ]);
      }).toList(),
    );
  }
}

class TableText extends StatelessWidget {
  final String text;
  const TableText(this.text, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Text(
        text,
        style: TextStyle(color: Theme.of(context).primaryColorDark),
      ),
    );
  }
}

class BooksList extends StatelessWidget {
  BooksList({super.key, required this.books, required this.isFavorite});

  final List<Book>? books;
  final bool isFavorite;
  final BookHelper helper = BookHelper();

  @override
  Widget build(BuildContext context) {
    final int booksCount = books!.length;
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.4,
      child: ListView.builder(
        itemCount: booksCount,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(books![index].title),
            subtitle: Text(books![index].authors),
            trailing: IconButton(
              color: (isFavorite) ? Colors.red : Colors.amber,
              tooltip:
                  (isFavorite) ? 'Remove from favourites' : 'Add to favourites',
              icon: const Icon(Icons.star),
              onPressed: () {
                if (isFavorite) {
                  helper.removeFromFavouites(books![index], context);
                } else {
                  helper.addToFavourites(books![index]);
                }
              },
            ),
          );
        },
      ),
    );
  }
}
