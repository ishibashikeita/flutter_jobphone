import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:job_phone/const/items.dart';
import 'package:job_phone/model/OrderItem.dart';

class FireStoreService {
  final db = FirebaseFirestore.instance.collection('order');

  Future create(OrderItem o) async {
    final snp = await db.doc(o.getSeat()).get();
    if (snp.exists == true) {
      final sn = snp.data() as Map<String, dynamic>;
      Map<String, dynamic> mp = o.getGoods();
      mp.forEach((key, value) {
        if (sn['goods'].containsKey(key) == false) {
          sn['goods'][key] = mp[key];
        } else {
          sn['goods'][key] = sn['goods'][key] + mp[key];
        }
      });

      await db.doc(o.getSeat()).update({
        'goods': sn['goods'],
        'sum': sn['sum'] + o.getSum(),
      });
    } else {
      await db.doc(o.getSeat()).set({
        'goods': o.getGoods(),
        'sum': o.getSum(),
        'time': o.getTime(),
      });
    }
  }

  Future<Map<String, dynamic>?> read(String s) async {
    final snp = await db.doc(s).get();
    if (snp.exists == true) {
      final sn = snp.data();
      return sn;
    }
  }

  Future<void> update() async {
    await db.doc('aaa').update({});
  }

  Future<void> delete(String s) async {
    await db.doc(s).delete();
  }
}
