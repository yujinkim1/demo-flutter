import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:gatcha_pedia/models/book.dart';
import 'package:gatcha_pedia/utilities/book_service.dart';
import 'package:gatcha_pedia/screens/webview_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController searchBarTextController;
  late FocusNode searchBarFocusNode;

  @override
  void initState() {
    super.initState();
    searchBarTextController = TextEditingController();
    searchBarFocusNode = FocusNode();
  }

  @override
  void dispose() {
    searchBarTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookService>(builder: (context, bookService, child) {
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
                "왓챠피디아",
                style: TextStyle(
                  color: Color(0xffFFFFFF),
                  fontSize: 32.0,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              SearchBar(
                onTap: () {
                  log("onTap");
                  searchBarFocusNode.requestFocus();
                },
                onChanged: (value) {
                  log("is typing: $value");
                  searchBarTextController.text = value;
                },
                hintText: "Search contents, people, collections, etc...",
                focusNode: searchBarFocusNode,
                textStyle: MaterialStateTextStyle.resolveWith(
                  (states) => const TextStyle(
                    color: Color(0xffF5F5F5),
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                elevation: MaterialStateProperty.all<double>(0),
                backgroundColor: MaterialStateColor.resolveWith(
                  (states) => const Color(0xffFF829D),
                ),
                surfaceTintColor: MaterialStateProperty.all<Color>(
                  const Color(0xffE57373),
                ),
                constraints: const BoxConstraints(
                  minHeight: 58.0,
                  maxHeight: 58.0,
                ),
                side: MaterialStateBorderSide.resolveWith(
                  (states) => const BorderSide(
                    color: Color(0xffFF829D),
                    width: 2.0,
                  ),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                trailing: <Widget>[
                  IconButton(
                    onPressed: () async {
                      await bookService.getBooks(
                        value: searchBarTextController.text.toString(),
                      );
                    },
                    icon: const Icon(
                      CupertinoIcons.search,
                      color: Color(0xffF5F5F5),
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
            itemCount: bookService.books.length,
            itemBuilder: (context, index) {
              if (bookService.books.isEmpty) {
                return const SizedBox.shrink();
              }
              Book book = bookService.books.elementAt(index);
              return BookTile(book: book);
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
          ),
        ),
      );
    });
  }
}

class BookTile extends StatelessWidget {
  const BookTile({
    Key? key,
    required this.book,
  }) : super(key: key);

  final Book book;

  @override
  Widget build(BuildContext context) {
    BookService bookService = context.read<BookService>();
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewScreen(
              url: book.previewLink.replaceFirst("http", "https"),
            ),
          ),
        );
      },
      leading: Image.network(
        book.thumbnail,
        width: 50.0,
        height: 50.0,
        fit: BoxFit.fitHeight,
      ),
      trailing: IconButton(
        onPressed: () {
          log("북마크: ${book.title}");
          bookService.bookmark(book: book);
        },
        icon: bookService.bookmarks.map((book) => book.id).contains(book.id)
            ? const Icon(
                CupertinoIcons.star_fill,
                color: Color(0xffFF2E5E),
              )
            : const Icon(
                CupertinoIcons.star,
                color: Color(0xff999999),
              ),
      ),
      title: Text(
        book.title,
        style: const TextStyle(fontSize: 16.0),
      ),
      subtitle: Text(
        book.subtitle,
        style: const TextStyle(
          color: Color(0xff999999),
        ),
      ),
    );
  }
}
