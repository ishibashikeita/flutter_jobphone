import 'package:flutter/material.dart';
import 'package:job_phone/ItemDetail.dart';
import 'const/items.dart';

class ItemListTile extends StatelessWidget {
  const ItemListTile({
    super.key,
    required this.tileList,
    required this.index,
    required this.tabController,
  });

  final List tileList;
  final int index;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.grey,
      onTap: () async {
        final cart = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (
            context,
          ) =>
                  ItemDetail(
                    itemList: item4[tabController.index][index],
                  )),
        );
        print(item4[tabController.index][index]);

        print(cart);
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black.withOpacity(0.5))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(tileList[index]),
            Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
