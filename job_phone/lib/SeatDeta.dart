import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/material.dart';
import 'package:job_phone/ItemSelect.dart';
import 'package:job_phone/confirmation.dart';
import 'package:job_phone/model/db.dart';
import 'package:job_phone/thank.dart';
import 'const/items.dart';
import 'package:intl/intl.dart';

class SeatData extends StatefulWidget {
  SeatData({
    super.key,
    required this.seat,
    required this.index,
  });

  final String seat;
  int index;

  @override
  State<SeatData> createState() => _SeatDataState();
}

class _SeatDataState extends State<SeatData> {
  @override
  Widget build(BuildContext context) {
    final service = FireStoreService();
    final s = widget.seat + (widget.index + 1).toString();

    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          splashColor: Colors.blue,
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SimpleDialog(
                        backgroundColor: Colors.black.withOpacity(0.1),
                        elevation: 0,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(50.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SimpleDialogOption(
                                  onPressed: () {
                                    data = {};
                                    data[widget.seat] = (widget.index + 1);

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ItemSelect(
                                          data: data,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.assignment_add,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      Text('追加',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                ),
                                FutureBuilder(
                                    future: service.read(s),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return SimpleDialogOption(
                                          onPressed: () {
                                            final map = service.read(s);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      confirmation(
                                                    map: map,
                                                    seatIndex: (widget.seat +
                                                        (widget.index + 1)
                                                            .toString()),
                                                  ),
                                                ));
                                          },
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.format_list_bulleted,
                                                color: Colors.white,
                                                size: 30,
                                              ),
                                              Text('確認',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ],
                                          ),
                                        );
                                      } else {
                                        return SimpleDialogOption(
                                          onPressed: () {
                                            Fluttertoast.showToast(
                                              msg: '注文済みの商品はありません。',
                                              backgroundColor:
                                                  Colors.black.withOpacity(0.3),
                                            );
                                          },
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.format_list_bulleted,
                                                color: Colors.white,
                                                size: 30,
                                              ),
                                              Text('確認',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ],
                                          ),
                                        );
                                      }
                                    }),
                                FutureBuilder(
                                    future: service.read(s),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return SimpleDialogOption(
                                          onPressed: () {
                                            service.delete(s);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        thank()));
                                          },
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                                size: 30,
                                              ),
                                              Text('会計',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ],
                                          ),
                                        );
                                      } else {
                                        return SimpleDialogOption(
                                          onPressed: () {
                                            Fluttertoast.showToast(
                                              msg: '注文済みの商品はありません。',
                                              backgroundColor:
                                                  Colors.black.withOpacity(0.3),
                                            );
                                          },
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                                size: 30,
                                              ),
                                              Text('会計',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ],
                                          ),
                                        );
                                      }
                                    }),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                });
          },
          child: StreamBuilder(
              stream: service.db.doc(s).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('aaa');
                }
                Map<String, dynamic> mapp = {};

                if (snapshot.data?.data() != null) {
                  mapp = snapshot.data!.data() as Map<String, dynamic>;
                }

                if (mapp.isNotEmpty) {
                  DateTime t = mapp['time'].toDate();

                  return Container(
                    //margin: EdgeInsets.all(3.0),
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                        // color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            widget.seat + (widget.index + 1).toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.person,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '1',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                '¥' + mapp['sum'].toString(),
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.schedule,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                DateFormat('kk:mm').format(t),
                                style:
                                    TextStyle(fontSize: 17, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 22.3,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'オーダー済',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return Container(
                    //margin: EdgeInsets.all(3.0),
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                        // color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            widget.seat + (widget.index + 1).toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }
}
