import 'package:flutter/material.dart';
import 'SeatDeta.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DemoPage(),
      theme: ThemeData(
        bottomSheetTheme:
            BottomSheetThemeData(backgroundColor: Colors.transparent),
      ),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('テーブル一覧'),
          backgroundColor: Colors.blue,
        ),
        body: PageView(
          controller: controller,
          onPageChanged: (value) {
            print(controller.initialPage);
          },
          children: [
            pages(
              seat: 'c',
              count: 6,
              back: 0,
            ),
            pages(
              seat: 't',
              count: 5,
              back: 1,
            ),
            pages(
              seat: 'z',
              count: 3,
              back: 2,
            ),
          ],
        ),
        bottomSheet: SizedBox(
          width: double.infinity,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SmoothPageIndicator(
                  controller: controller,
                  count: 3,
                  effect: SlideEffect(
                    dotWidth: 10.0,
                    dotHeight: 10.0,
                  ),
                  onDotClicked: (index) {}),
            ],
          ),
        ));
  }
}

class pages extends StatelessWidget {
  pages({
    super.key,
    required this.count,
    required this.seat,
    required this.back,
  });
  int count;
  String seat;
  int back;

  @override
  Widget build(BuildContext context) {
    return Container(
      color:
          (back % 2 == 0) ? Colors.lightBlue.shade100 : Colors.yellow.shade100,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Row(
              children: [
                Icon(
                  Icons.person,
                  size: 40,
                ),
                Text(
                  'アルバイト1',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8.0),
            child: Text(
              (seat == 'c')
                  ? 'カウンター'
                  : (seat == 't')
                      ? 'テーブル'
                      : '座敷',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: count,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                return SeatData(seat: seat, index: index);
              },
            ),
          ),
        ],
      ),
    );
  }
}
