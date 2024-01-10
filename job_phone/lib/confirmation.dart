import 'package:flutter/material.dart';
import 'const/items.dart';

class confirmation extends StatefulWidget {
  confirmation({super.key, required this.map, required this.seatIndex});
  final seatIndex;
  Future<dynamic> map;

  @override
  State<confirmation> createState() => _confirmationState();
}

class _confirmationState extends State<confirmation> {
  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    return FutureBuilder(
        future: widget.map,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> data = snapshot.data;
            Map<String, dynamic> itemMap = data[data.keys.elementAt(0)];

            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blue,
                title: Text(widget.seatIndex),
              ),
              body: ListView.builder(
                  itemCount: itemMap.length,
                  itemBuilder: ((context, index) {
                    return ListTile(
                      title: Text(
                        itemMap.keys.elementAt(index),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          goods[itemMap.keys.elementAt(index)].toString() +
                              '円'),
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
                            itemMap[itemMap.keys.elementAt(index)].toString(),
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  })),
              bottomSheet: Container(
                width: double.infinity,
                height: deviceHeight * 0.15,
                color: Colors.blueGrey.shade100,
                alignment: Alignment.center,
                child: FractionallySizedBox(
                  widthFactor: 0.8,
                  heightFactor: 0.6,
                  child: Container(
                    child: Center(
                      child: Text(
                        '合計金額 : ' +
                            data[data.keys.elementAt(1)].toString() +
                            '円',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              body: Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    strokeWidth: 8.0,
                  ),
                ),
              ),
            );
          }
        }));
  }
}
