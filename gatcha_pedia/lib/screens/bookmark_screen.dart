import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:gatcha_pedia/models/book.dart';
import 'package:gatcha_pedia/utilities/book_service.dart';
import 'package:gatcha_pedia/screens/home_screen.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BookService>(
      builder: (context, bookService, child) {
        int bookmarkCount = bookService.bookmarks.length;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xffFF0558),
            elevation: 0,
            centerTitle: false,
            toolbarHeight: 150.0,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "북마크",
                  style: TextStyle(
                    color: Color(0xffFFFFFF),
                    fontSize: 32.0,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    const Icon(
                      CupertinoIcons.bookmark_fill,
                      size: 28.0,
                      color: Color(0xffFFFFFF),
                    ),
                    const SizedBox(width: 16.0),
                    Text(
                      "$bookmarkCount",
                      style: const TextStyle(
                        color: Color(0xffFFFFFF),
                        fontSize: 32.0,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: ListView.separated(
              itemCount: bookService.bookmarks.length,
              itemBuilder: (context, index) {
                if (bookService.bookmarks.isEmpty) {
                  return const SizedBox.shrink();
                }
                Book book = bookService.bookmarks.elementAt(index);
                return BookTile(book: book);
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            ),
          ),
        );
      },
    );
  }
}
