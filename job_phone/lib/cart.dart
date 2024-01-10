import 'package:flutter/material.dart';
import 'package:job_phone/cartThank.dart';
import 'package:job_phone/main.dart';
import 'package:job_phone/model/OrderItem.dart';
import 'SeatDeta.dart';
import 'const/items.dart';
import 'model/db.dart';
import 'model/OrderItem.dart';

class Cart extends StatefulWidget {
  Cart({super.key, required this.cart});
  final Map<String, int> cart;

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    int sum = 0;
    OrderItem order = OrderItem();
    return Scaffold(
      appBar: AppBar(
        title: const Text('注文確定画面'),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: widget.cart.length,
            itemBuilder: (BuildContext context, index) {
              var key = widget.cart.keys.elementAt(index);
              return ListTile(
                title: Text(
                  key,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(goods[key].toString() + '円'),
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.restaurant,
                      color: Colors.black,
                    ),
                  ],
                ),
                tileColor: (index % 2 == 0)
                    ? Colors.white
                    : Colors.black.withOpacity(0.05),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.cart[key].toString(),
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            },
          ),
          //何でエラーなのかわかんないけどほんとはこれを使いたかった、、
          // SlideAction(
          //   height: 20,
          //   innerColor: Colors.black,
          //   outerColor: Colors.white,
          //   onSubmit: () {},
          // )
        ],
      ),
      bottomSheet: Container(
        width: double.infinity,
        height: deviceHeight * 0.15,
        color: Colors.blueGrey.shade100,
        alignment: Alignment.center,
        child: FractionallySizedBox(
          widthFactor: 0.8,
          heightFactor: 0.6,
          child: Container(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                side: BorderSide(color: Colors.white),
                backgroundColor: Colors.orange,
              ),
              child: Text(
                '確定',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              onPressed: () {
                widget.cart.forEach(((String key, int value) {
                  sum += ((goods[key]!) * value);
                }));

                // Map<String, Map<String, dynamic>> map = {
                //   (data.keys.first + data[data.keys.first].toString()): {
                //     'goods': widget.cart,
                //     'time': DateTime.now(),
                //     'sum': sum,
                //   },
                // };

                order.setOrder(
                  //座席
                  (data.keys.first + data[data.keys.first].toString()),
                  //時間
                  DateTime.now(),
                  //合計金額
                  sum,
                  //商品
                  widget.cart,
                );

                final service = FireStoreService();
                service.create(order);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartThank()),
                );

                //データベースに入れる値
                //選択した席
                // print(data);
                // //商品
                // print(widget.cart);
                // //時間
                // print(DateTime.now().toString());
                // //合計
                // print(sum);
              },
            ),
          ),
        ),
      ),
    );
  }
}
