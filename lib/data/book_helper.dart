import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import '../favourite_screen.dart';
import 'book.dart';

class BookHelper {
  final String UrlKey = '&key=AIzaSyDWyB49oZ8u1za537OwDdDaPxdh79nOruM';
  final String urlQuery = 'volumes?q=';
  final urlBase = 'https://www.googleapis.com/books/v1/';

  Future<List<Book>> getBooks(String query) async {
    List<Book> books = [];
    final String url = urlBase + urlQuery + query + UrlKey;
    print('Making API request to: $url');
    http.Response result = await http.get(Uri.parse(url));
    print('Received response with status code: ${result.statusCode}');
    if (result.statusCode == HttpStatus.ok) {
      var jsonResponse = json.decode(result.body);
      var bookMap = jsonResponse['items'] as List;
      books = bookMap.map((i) => Book.fromJson(i)).toList();
    }
    return books;
  }

  Future addToFavourites(Book book) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString(book.id);
    if (id != '') {
      await prefs.setString(book.id, json.encode(book.toJson()));
    }
  }

  Future removeFromFavouites(Book book, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString(book.id);
    if (id != '') {
      await prefs.remove(book.id);
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const FavouriteScreen(),
        ),
      );
    }
  }

  Future<List<Book>> getFavorites() async {
// returns the favorite books or an empty list
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Book> favBooks = [];
    Set allKeys = prefs.getKeys();
    if (allKeys.isNotEmpty) {
      for (int i = 0; i < allKeys.length; i++) {
        String key = (allKeys.elementAt(i).toString());
        String value = prefs.get(key) as String;
        dynamic json = jsonDecode(value);
        Book book = Book(
          id: json['id'],
          title: json['title'],
          authors: json['authors'],
          description: json['description'],
          publisher: json['publisher'],
        );
        favBooks.add(book);
      }
    }
    return favBooks;
  }
}
