import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';

import 'package:dio/dio.dart';

import 'package:gatcha_pedia/main.dart';
import 'package:gatcha_pedia/models/book.dart';

class BookService extends ChangeNotifier {
  final Dio dio = Dio();

  List<Book> books = [];
  List<Book> bookmarks = [];

  BookService() {
    loadBookmarks();
  }

  Future<void> getBooks({
    required String value,
  }) async {
    books.clear();
    try {
      var response = await dio.get(
        "https://www.googleapis.com/books/v1/volumes?q=$value&statrtIndex=0&maxResults=40",
      );
      List items = response.data['items'];

      for (Map<String, dynamic> item in items) {
        String id = item["id"];
        String title = item["volumeInfo"]["title"] ?? "";
        String subtitle = item['volumeInfo']["subtitle"] ?? "";
        String thumnail = item["volumeInfo"]["imageLinks"]?["thumbnail"] ??
            "https://thumbs.dreamstime.com/b/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132482953.jpg";
        String previewLink = item["volumeInfo"]["previewLink"] ?? "";

        books.add(
          Book(
            id: id,
            title: title,
            subtitle: subtitle,
            thumbnail: thumnail,
            previewLink: previewLink,
          ),
        );
      }
      notifyListeners();
    } catch (e) {
      log("예기치 못한 오류가 발생했습니다: $e");
    }
  }

  void bookmark({required Book book}) {
    String id = book.id;
    if (bookmarks.map((e) => book.id).contains(id)) {
      bookmarks.removeWhere((e) => e.id == id);
    } else {
      bookmarks.add(book);
    }
    notifyListeners();
  }

  void saveFavoriteBooks() async {
    List favoriteJsonBooks = bookmarks.map((e) => e.toJson()).toList();
    String favoriteJsonData = jsonEncode(favoriteJsonBooks);
    sharedPrefs.setString("favoriteBooks", favoriteJsonData);
  }

  void loadBookmarks() {
    String? jsonData = sharedPrefs.getString("favoriteBooks");
    if (jsonData == null) return;
    List favoriteJsonData = jsonDecode(jsonData);
    bookmarks = favoriteJsonData.map((e) => Book.fromJson(e)).toList();
  }
}
