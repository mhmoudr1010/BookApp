import 'package:book_app/data/book.dart';
import 'package:book_app/ui.dart';
import 'package:flutter/material.dart';
import './data/book_helper.dart';
import 'favourite_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late BookHelper helper;
  List<Book>? books = <Book>[];
  int? booksCount;
  late TextEditingController txtSearchController;

  @override
  void initState() {
    helper = BookHelper();
    txtSearchController = TextEditingController();
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
        title: const Text('My Books'),
        actions: <Widget>[
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: (isSmall) ? const Icon(Icons.home) : const Text("Home"),
            ),
          ),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child:
                  (isSmall) ? const Icon(Icons.star) : const Text('Favorites'),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FavouriteScreen()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const Text('Search book'),
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: 200,
                    child: TextField(
                      controller: txtSearchController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (text) {
                        helper.getBooks(text).then((value) {
                          setState(() {
                            books = value;
                          });
                        });
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        helper.getBooks(txtSearchController.text).then(
                          (value) {
                            setState(() {
                              books = value;
                            });
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: (isSmall)
                  ? BooksList(books: books, isFavorite: false)
                  : BooksTable(books: books, isFavorite: false),
            ),
          ],
        ),
      ),
    );
  }

  Future initialize() async {
    books = await helper.getBooks('Flutter');
    setState(() {
      booksCount = books?.length;
      books = books;
    });
  }
}
