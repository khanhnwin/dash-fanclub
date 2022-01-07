import 'bag_item.dart';

class Bag {
  List<BagItem> items = [];

  List<BagItem> add(BagItem item) {
    items.add(item);

    return items;
  }

  BagItem getItem(int index) {
    return items[index];
  }

  List<BagItem> deleteItem(int index) {
    items.removeAt(index);

    return items;
  }

  List<BagItem> updateItemQuantity(int index, int quantity) {
    items[index].quantity = quantity;

    return items;
  }

  void outputBag() {
    print("Outputting Bag contents!");
    print("============================");
    for (int i = 0; i < items.length; i++) {
      print(items[i].item.productValues);
      print(items[i].quantity);
      print(items[i].size);
    }
    print("============================");
  }
}
