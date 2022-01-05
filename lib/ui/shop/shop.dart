import 'package:flutter/material.dart';
import '../../api/shop_inventory.dart';

class DashShop extends StatefulWidget {
  const DashShop({Key? key}) : super(key: key);

  @override
  _DashShopState createState() => _DashShopState();
}

class _DashShopState extends State<DashShop> {
  final ShopInventory inventoryManager = ShopInventory();
  late Map<String, Product> inventory;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inventory = inventoryManager.getAllProducts();
  }

  void applyFilter() {}

  @override
  Widget build(BuildContext context) {
    List<Widget> productTiles = [];

    inventory.forEach((String productId, Product item) {
      print(item.productValues);
      productTiles.add(
        Card(
          child: Column(
            children: [
              SizedBox(
                width: 500,
                height: 175,
                child: Image(
                  image: AssetImage(item.firstImage),
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                item.name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Text(
                  "\$${item.price.toString()}",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary),
                ),
              ),
            ],
          ),
        ),
      );
    });

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Row(
            children: [
              ElevatedButton(
                onPressed: applyFilter,
                child: Row(
                  children: const [
                    Icon(
                      Icons.filter_list,
                      size: 16,
                      semanticLabel: "filter",
                    ),
                    SizedBox(width: 10),
                    Text("filter", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Expanded(
                child: SizedBox(
                  height: 38,
                  child: TextField(
                    autofocus: false,
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Flexible(
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 20,
            padding: const EdgeInsets.all(10),
            children: productTiles,
            childAspectRatio: 0.70,
          ),
        ),
      ],
    );
  }
}
