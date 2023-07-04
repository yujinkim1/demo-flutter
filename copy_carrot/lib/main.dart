import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CopyCarrot",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xffFFFFFF),
        appBar: AppBar(
          backgroundColor: const Color(0xffFFFFFF),
          elevation: 0.0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          leadingWidth: 120.0,
          leading: GestureDetector(
            onTap: () {
              log("leading clicked");
            },
            child: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text(
                    "초평동",
                    style: TextStyle(
                      color: Color(0xff000000),
                      fontWeight: FontWeight.bold,
                      fontSize: 26.0,
                    ),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Color(0xff000000),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: GestureDetector(
                onTap: () {
                  log("menu clicked");
                },
                child: const Icon(
                  CupertinoIcons.bars,
                  size: 30.0,
                  color: Color(0xff000000),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: GestureDetector(
                onTap: () {
                  log("search clicked");
                },
                child: const Icon(
                  CupertinoIcons.search,
                  size: 30.0,
                  color: Color(0xff000000),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: GestureDetector(
                onTap: () {
                  log("bell clicked");
                },
                child: const Icon(
                  CupertinoIcons.bell,
                  size: 30.0,
                  color: Color(0xff000000),
                ),
              ),
            ),
          ],
        ),
        body: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          itemCount: feeds.length,
          itemBuilder: (_, int index) {
            final imageUri = feeds[index]["imageUri"];
            final title = feeds[index]["title"];
            final location = feeds[index]["location"];
            final time = feeds[index]["time"];
            final price = feeds[index]["price"];
            return GestureDetector(
              onTap: () {
                log("feed clicked");
              },
              child: FeedWidget(
                imageUri: imageUri,
                title: title,
                location: location,
                time: time,
                price: price,
              ),
            );
          },
          separatorBuilder: (_, int index) {
            return const Divider();
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          elevation: 2.0,
          hoverElevation: 0.0,
          focusElevation: 0.0,
          backgroundColor: const Color(0xffFF8900),
          icon: const Icon(
            Icons.add,
            size: 30.0,
            color: Color(0xffFFFFFF),
          ),
          label: const Text(
            "글쓰기",
            style: TextStyle(
              color: Color(0xffFFFFFF),
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          fixedColor: const Color(0xff000000),
          unselectedItemColor: const Color(0xff000000),
          showUnselectedLabels: true,
          selectedFontSize: 12.0,
          unselectedFontSize: 12.0,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_filled,
                size: 30.0,
              ),
              label: "홈",
              backgroundColor: Color(0xffFFFFFF),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.my_library_books_outlined,
                size: 30.0,
              ),
              label: "동네생활",
              backgroundColor: Color(0xffFFFFFF),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.fmd_good_outlined,
                size: 30.0,
              ),
              label: "내 근처",
              backgroundColor: Color(0xffFFFFFF),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.chat_bubble_2,
                size: 30.0,
              ),
              label: " 채팅",
              backgroundColor: Color(0xffFFFFFF),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
                size: 30.0,
              ),
              label: "나의 당근",
              backgroundColor: Color(0xffFFFFFF),
            ),
          ],
          currentIndex: 0,
        ),
      ),
    );
  }
}

class FeedWidget extends StatefulWidget {
  const FeedWidget({
    Key? key,
    required this.imageUri,
    required this.title,
    required this.location,
    required this.time,
    required this.price,
  }) : super(key: key);

  final String imageUri;
  final String title;
  final String location;
  final String time;
  final String price;

  @override
  State<FeedWidget> createState() => _FeedWidgetState();
}

class _FeedWidgetState extends State<FeedWidget> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            widget.imageUri,
            width: 100.0,
            height: 100.0,
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  softWrap: false,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4.0),
                Text(
                  "${widget.location} · ${widget.time}",
                  style: const TextStyle(
                    color: Color(0xff999999),
                    fontSize: 12.0,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  widget.price,
                  style: const TextStyle(
                    color: Color(0xff000000),
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                Row(
                  children: [
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                      child: Icon(
                        isFavorite
                            ? CupertinoIcons.heart_fill
                            : CupertinoIcons.heart,
                        size: 18.0,
                        color: isFavorite
                            ? const Color(0xfff44336)
                            : const Color(0xff999999),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

final List<Map<String, dynamic>> feeds = [
  {
    "imageUri": "https://cdn2.thecatapi.com/images/6bt.jpg",
    "title": "M1 아이패드 프로 11형(3세대) 와이파이 128G",
    "location": "수청동",
    "time": "1분 전",
    "price": "1,000,000원",
  },
  {
    "imageUri": "https://cdn2.thecatapi.com/images/ahr.jpg",
    "title": "오산 소품샵 마이니즈 신상 팝니다.",
    "location": "고현동",
    "time": "1시간 전",
    "price": "18,000원",
  },
  {
    "imageUri": "https://cdn2.thecatapi.com/images/arj.jpg",
    "title": "8인용 대형식탁의자세트(A급)",
    "location": "세마동",
    "time": "1시간 전",
    "price": "470,000원",
  },
  {
    "imageUri": "https://cdn2.thecatapi.com/images/brt.jpg",
    "title": "아이폰14 미드나이트 128기가",
    "location": "세교동",
    "time": "3시간 전",
    "price": "825,000원",
  },
  {
    "imageUri": "https://cdn2.thecatapi.com/images/cml.jpg",
    "title": "히타치 빔프로젝터 CP-X3010 팔아요.",
    "location": "원동",
    "time": "3시간 전",
    "price": "300,000원",
  },
  {
    "imageUri": "https://cdn2.thecatapi.com/images/e35.jpg",
    "title": "삼성 냉장고 팔아요.",
    "location": "초평동",
    "time": "3시간 전",
    "price": "200,000원",
  },
  {
    "imageUri": "https://cdn2.thecatapi.com/images/MTk4MTAxOQ.jpg",
    "title": "맥북에어 m2 풀박스 사이클17",
    "location": "금암동",
    "time": "4시간 전",
    "price": "900,000원",
  },
  {
    "imageUri": "https://cdn2.thecatapi.com/images/MjA0ODM5MQ.jpg",
    "title": "닌텐도 팔아요 (A급)",
    "location": "누읍동",
    "time": "4시간 전",
    "price": "280,000원",
  },
  {
    "imageUri": "https://cdn2.thecatapi.com/images/AuY1uMdmi.jpg",
    "title": "다용도 5단 선반장 (상태좋음)",
    "location": "세교동",
    "time": "5시간 전",
    "price": "25,000원",
  },
  {
    "imageUri": "https://cdn2.thecatapi.com/images/6bt.jpg",
    "title": "[제네시스 G70 IK 2.0T AWD 엘리트] 20년식, 3.2만km",
    "location": "초평동",
    "time": "5시간 전",
    "price": "300,000원",
  },
];
