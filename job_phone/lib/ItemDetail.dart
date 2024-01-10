import 'package:flutter/material.dart';
import 'package:job_phone/cart.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ItemDetail extends StatefulWidget {
  ItemDetail({super.key, required this.itemList});
  final List<String> itemList;

  @override
  State<ItemDetail> createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  late List<int> count = new List.generate(widget.itemList.length, (i) => 0);
  Map<String, int> add = {};

  @override
  Widget build(BuildContext context) {
    BuildContext innercontext = context;
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 25,
          ),
          onPressed: () {
            // Navigator.pop(context, count);

            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                innercontext = context;
                return AlertDialog(
                  title: Center(
                    child: Text(
                      "※確認",
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    ),
                  ),
                  content: Text("前の画面に戻っても大丈夫ですか？\n(商品の選択は解除されます。)"),
                  actions: [
                    TextButton(
                      child: Text("Cancel"),
                      onPressed: () => Navigator.pop(context, count),
                    ),
                    TextButton(
                        child: Text("OK"),
                        onPressed: () {
                          //pop２つで解決してるけど、、他のやり方ある？
                          Navigator.of(context).pop();
                          Navigator.of(context).pop(count);
                        }),
                  ],
                );
              },
            );
            // showDialog(
            //     context: context,
            //     builder: (BuildContext context) {
            //       return AlertDialog(
            //         title: Text('残ってるよ'),
            //         actions: [
            //           GestureDetector(
            //             onTap: () {},
            //             child: Text('いいえ'),
            //           ),
            //           GestureDetector(
            //             onTap: () {
            //               Navigator.pop(context, count);
            //             },
            //             child: Text('はい'),
            //           ),
            //         ],
            //       );
            //     });

            // final isEmpty = count.every((item) => item == 0);
            // if (isEmpty == true) {
            //   count = null;
            // }

            //
          },
        ),
        title: Text('商品追加画面'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'お通し>コース',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: widget.itemList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 3,
                      mainAxisSpacing: 3,
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border:
                              Border.all(color: Colors.black.withOpacity(0.2)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.itemList[index],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      if (count[index] != 0) {
                                        setState(() {
                                          count[index]--;
                                        });
                                      }
                                      print('-');
                                      print(count);
                                    },
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      size: 10,
                                    )),
                                Text(
                                  count[index].toString(),
                                  style: TextStyle(fontSize: 20),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        count[index]++;
                                      });

                                      print('+');
                                      print(count);
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 10,
                                    )),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 10.0,
              right: 10.0,
              width: 100.0,
              height: 100.0,
              child: ElevatedButton(
                onPressed: () {
                  add = {};
                  count.asMap().forEach((int i, int value) {
                    if (value > 0) {
                      add[widget.itemList[i]] = value;
                    }
                  });

                  if (add.isEmpty == true) {
                    Fluttertoast.showToast(
                      msg: '商品が選択されていません。',
                      backgroundColor: Colors.black.withOpacity(0.3),
                    );
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Cart(cart: add)));
                  }
                },
                child: Icon(
                  Icons.shopping_cart,
                  size: 50,
                ),
                style: ButtonStyle(
                  shape:
                      MaterialStateProperty.all<CircleBorder>(CircleBorder()),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                  elevation: MaterialStateProperty.all<double>(4.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
