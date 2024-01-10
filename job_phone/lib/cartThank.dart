import 'package:flutter/material.dart';
import 'package:job_phone/main.dart';

class CartThank extends StatefulWidget {
  const CartThank({super.key});

  @override
  State<CartThank> createState() => _CartThankState();
}

class _CartThankState extends State<CartThank> {
  @override
  void initState() {
    super.initState();
    void hoge() async {
      await Future.delayed(Duration(seconds: 1));
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
    }

    hoge();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              size: 100,
              color: Colors.green,
            ),
            Text(
              'ご注文が完了しました！',
              style: TextStyle(fontSize: 35),
            ),
            CircularProgressIndicator.adaptive(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('数秒後にホームへ戻ります')],
            )
          ],
        ),
      ),
    );
  }
}
