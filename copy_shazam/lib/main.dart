import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "CopyShazam",
      debugShowCheckedModeBanner: false,
      home: ShazamScreen(),
    );
  }
}

class ShazamScreen extends StatefulWidget {
  const ShazamScreen({Key? key}) : super(key: key);

  @override
  State<ShazamScreen> createState() => _ShazamScreenState();
}

class _ShazamScreenState extends State<ShazamScreen> {
  double? width;
  double? height;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff000000),
      appBar: AppBar(
        backgroundColor: const Color(0xff000000),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: height! * 0.1),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.mic_rounded,
                    size: 30.0,
                    color: Color(0xffFFFFFF),
                  ),
                  Text(
                    "터치하여 Shazam하기",
                    style: TextStyle(
                      color: Color(0xffFFFFFF),
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height! * 0.1),
              AnimatedContainer(
                alignment: Alignment.center,
                duration: const Duration(milliseconds: 500),
                curve: Curves.bounceInOut,
                width: 200.0,
                height: 200.0,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(100, 153, 153, 153),
                  shape: BoxShape.circle,
                ),
                child: Image.network(
                  "https://i.ibb.co/hxNbZ8p/shazam.png",
                  color: const Color(0xffFFFFFF),
                  width: 150.0,
                  height: 150.0,
                ),
              ),
              SizedBox(height: height! * 0.05),
              NudgeCardWidget(width: width! * 0.9, height: height! * 0.2),
            ],
          ),
          bottomLibraryWidget(width!, height!),
        ],
      ),
    );
  }

  Widget bottomLibraryWidget(double width, double height) {
    return DraggableScrollableSheet(
      initialChildSize: 0.15,
      minChildSize: 0.15,
      builder: (_, ScrollController scrollController) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(),
          controller: scrollController,
          child: Container(
            width: width * 0.9,
            height: height,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 20, 31, 27),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          "내 음악",
                          style: TextStyle(
                            color: Color(0xffFFFFFF),
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(right: 16.0),
                        child: Text(
                          "Shazam 5개",
                          style: TextStyle(
                            color: Color(0xff999999),
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        mainAxisSpacing: 16.0,
                        crossAxisSpacing: 16.0,
                      ),
                      itemCount: musics.length,
                      itemBuilder: (_, int index) {
                        return Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xffFFFFFF).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: Image.network(
                                  musics[index]["imageUri"],
                                  width: 150.0,
                                  height: 150.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            Text(
                              musics[index]["title"],
                              style: const TextStyle(
                                color: Color(0xffFFFFFF),
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              musics[index]["artist"],
                              style: const TextStyle(
                                color: Color(0xffFFFFFF),
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class NudgeCardWidget extends StatelessWidget {
  const NudgeCardWidget({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height! * 0.75,
      decoration: BoxDecoration(
          color: const Color(0xffFFFFFF).withOpacity(0.1),
          border: Border.all(
            color: const Color(0xffFFFFFF).withOpacity(0.5),
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(16.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8.0, top: 16.0),
            child: Text(
              "SHAZAM 및 APPLE MUSIC",
              style: TextStyle(
                  color: Color(0xffFFFFFF),
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.network(
                    "https://i.ibb.co/hxNbZ8p/shazam.png",
                    color: const Color(0xffFFFFFF),
                    width: 50.0,
                    height: 50.0,
                  ),
                ),
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0, top: 8.0),
                  child: Text(
                    "Shazam의 기능으로 Apple Music을 최대한으로 활용해 보세요",
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      color: Color(0xffFFFFFF),
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

const List<Map<String, dynamic>> musics = [
  {
    "imageUri":
        "https://upload.wikimedia.org/wikipedia/en/1/10/NewJeans_OMG_cover.jpg",
    "title": "OMG",
    "artist": "NewJeans",
  },
  {
    "imageUri":
        "https://t2.genius.com/unsafe/504x504/https%3A%2F%2Fimages.genius.com%2F10d299ec676946db064a075ad2116f9f.300x300x1.jpg",
    "title": "I AM",
    "artist": "아이브",
  },
  {
    "imageUri":
        "https://media.glamour.com/photos/61d88e76fb51b5359c910f55/3:2/w_999,h_665,c_limit/the-weeknd.png",
    "title": "Popular",
    "artist": "The Weeknd",
  },
  {
    "imageUri":
        "https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/a1/c5/24/a1c52439-a3ba-8c73-fa1b-85dfaa18cca4/PCSP_04999_A.jpg/1200x1200bf-60.jpg",
    "title": "TATTO",
    "artist": "Official HIGE DANdism",
  },
  {
    "imageUri":
        "https://www.lyrical-nonsense.com/wp-content/uploads/2022/07/Yorushika-Left-Right-Confusion.jpg",
    "title": "Miyako ochi",
    "artist": "Yorushika",
  }
];
