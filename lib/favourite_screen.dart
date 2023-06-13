import 'package:book_app/data/book.dart';
import 'package:flutter/material.dart';
import 'ui.dart';
import './data/book_helper.dart';
import 'main.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  late BookHelper helper;
  List<Book> books = [];
  int? booksCount;

  @override
  void initState() {
    helper = BookHelper();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isSmall = false;
    if (MediaQuery.of(context).size.width < 600) {
      isSmall = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Books'),
        actions: [
          InkWell(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: (isSmall) ? const Icon(Icons.home) : const Text('Home')),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()));
            },
          ),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child:
                  (isSmall) ? const Icon(Icons.star) : const Text("Favourites"),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
              padding: EdgeInsets.all(20), child: Text('My Favourite Books')),
          Padding(
            padding: const EdgeInsets.all(20),
            child: (isSmall)
                ? BooksList(
                    books: books,
                    isFavorite: true,
                  )
                : BooksTable(
                    books: books,
                    isFavorite: true,
                  ),
          ),
        ],
      ),
    );
  }

  Future initialize() async {
    books = await helper.getFavorites();
    setState(() {
      booksCount = books.length;
      books = books;
    });
  }
}
