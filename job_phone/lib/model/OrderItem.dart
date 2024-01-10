class OrderItem {
  String seat = '';
  DateTime time = DateTime.now();
  int sum = 0;
  Map goods = {};

  void setOrder(String s, DateTime t, int i, Map g) {
    seat = s;
    time = t;
    sum = i;
    goods = g;
  }

  getSeat() {
    return seat;
  }

  getTime() {
    return time;
  }

  getSum() {
    return sum;
  }

  getGoods() {
    return goods;
  }
}
