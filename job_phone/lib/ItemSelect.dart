import 'package:flutter/material.dart';
import 'ItemListTile.dart';
import 'const/items.dart';

class ItemSelect extends StatefulWidget {
  const ItemSelect({super.key, required this.data});
  final data;

  @override
  State<ItemSelect> createState() => _ItemSelectState();
}

late TabController _tabController;

class _ItemSelectState extends State<ItemSelect>
    with SingleTickerProviderStateMixin {
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: (Text(
          '商品選択画面',
          // widget.data.keys.elementAt(0) + data.values.elementAt(0).toString(),
        )),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              text: 'お通し・コース',
            ),
            Tab(text: '飲み物'),
            Tab(text: 'フード'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView.builder(
              itemCount: item.length,
              itemBuilder: (BuildContext context, index) {
                return ItemListTile(
                  index: index,
                  tileList: item,
                  tabController: _tabController,
                );
              }),
          ListView.builder(
              itemCount: item2.length,
              itemBuilder: (BuildContext context, index) {
                return ItemListTile(
                  index: index,
                  tileList: item2,
                  tabController: _tabController,
                );
              }),
          ListView.builder(
              itemCount: item3.length,
              itemBuilder: (BuildContext context, index) {
                return ItemListTile(
                  index: index,
                  tileList: item3,
                  tabController: _tabController,
                );
              }),
        ],
      ),
    );
  }
}
