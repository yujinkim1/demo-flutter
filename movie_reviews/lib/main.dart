import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

/// 메인 앱 위젯
class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Movie Reviews",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: const Color(0xffFFFFFF),
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: false,
          backgroundColor: const Color(0xffFFFFFF),
          title: const Text(
            "Movie Reviews",
            style: TextStyle(
              color: Color(0xff000000),
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.person_outlined,
                color: Color(0xff000000),
              ),
            ),
          ],
        ),
        body: const Column(
          children: <Widget>[
            SearchBarWidget(),
            Divider(height: 1.0),
            MovieListWidget(),
          ],
        ),
      ),
    );
  }
}

/// 검색바 위젯
class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff000000)),
          ),
          labelText: "영화 제목을 검색해주세요.",
          suffixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ),
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

/// 영화 목록 위젯
class MovieListWidget extends StatelessWidget {
  const MovieListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (_, int index) {
          String category = movies[index]["category"];
          String imageUri = movies[index]["imageUri"];
          return Card(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Image.network(
                  imageUri,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200.0,
                ),
                Container(
                  width: double.infinity,
                  height: 200.0,
                  color: const Color(0xff000000).withOpacity(0.3),
                ),
                Text(
                  category,
                  style: const TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.normal,
                    color: Color(0xffFFFFFF),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// 영화 데이터
List<Map<String, dynamic>> movies = [
  {
    "category": "탑건: 매버릭",
    "imageUri": "https://i.ibb.co/sR32PN3/topgun.jpg",
  },
  {
    "category": "마녀2",
    "imageUri": "https://i.ibb.co/CKMrv91/The-Witch.jpg",
  },
  {
    "category": "범죄도시2",
    "imageUri": "https://i.ibb.co/2czdVdm/The-Outlaws.jpg",
  },
  {
    "category": "헤어질 결심",
    "imageUri": "https://i.ibb.co/gM394CV/Decision-to-Leave.jpg",
  },
  {
    "category": "브로커",
    "imageUri": "https://i.ibb.co/MSy1XNB/broker.jpg",
  },
  {
    "category": "문폴",
    "imageUri": "https://i.ibb.co/4JYHHyc/Moonfall.jpg",
  },
];
