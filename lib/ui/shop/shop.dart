import 'dart:developer';

import 'package:flutter/material.dart';
import '../../api/shop_inventory.dart';
import '../../api/bag.dart';
import './product.dart';
import './bag.dart';
import 'package:get_it/get_it.dart';
import 'package:dash_fanclub_app/ui/shared/shared.dart';

GetIt getIt = GetIt.instance;

class DashShop extends StatefulWidget {
  const DashShop({Key? key}) : super(key: key);

  @override
  _DashShopState createState() => _DashShopState();
}

class _DashShopState extends State<DashShop> {
  final ShopInventory inventoryManager = ShopInventory();
  late Map<String, Product> inventory;
  late Product selectedProduct;

  @override
  void initState() {
    super.initState();
    inventory = inventoryManager.getAllProducts();
  }

  void _openProduct(BuildContext context, Product item) async {
    // Push Product page on top of stack
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProductPage(product: item)));

    getIt<Bag>().outputBag();
  }

  void _openBag(BuildContext context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const BagPage()));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> productTiles = [];

    inventory.forEach((String productId, Product item) {
      productTiles.add(
        GestureDetector(
          onTap: () {
            _openProduct(context, item);
          },
          child: ProductTile(
              image: item.firstImage,
              productName: item.name,
              price: item.price),
        ),
      );
    });

    return Stack(
      children: [
        Column(
          children: [
            const ShopBar(),
            ProductGrid(
              productTiles: productTiles,
            ),
            BagButton(onPressed: _openBag),
          ],
        ),
      ],
    );
  }
}

// This bar can be stateless for now since it's not functional
class ShopBar extends StatelessWidget {
  const ShopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () => {},
            child: Row(
              children: const [
                Icon(
                  Icons.filter_list,
                  size: 16,
                  semanticLabel: "filter",
                ),
                Whitespace(width: 10),
                Text("filter", style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          const Whitespace(
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
    );
  }
}

class ProductGrid extends StatelessWidget {
  const ProductGrid({required this.productTiles, Key? key}) : super(key: key);

  final List<Widget> productTiles;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 20,
        padding: const EdgeInsets.all(10),
        children: productTiles,
        childAspectRatio: 0.7,
      ),
    );
  }
}

class BagButton extends StatelessWidget {
  const BagButton({required this.onPressed, Key? key}) : super(key: key);

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 15, 15),
      child: Align(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          child: const Icon(Icons.shopping_bag_sharp, color: Colors.white),
          onPressed: () {
            onPressed(context);
          },
        ),
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  const ProductTile(
      {required this.image,
      required this.productName,
      required this.price,
      Key? key})
      : super(key: key);

  final String image;
  final String productName;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          SizedBox(
            width: 500,
            height: 175,
            child: Hero(
              tag: image,
              child: Image(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Whitespace(
            height: 10,
          ),
          Text(
            productName,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Whitespace(
            height: 10,
          ),
          Expanded(
            child: Text(
              "\$${price.toString()}",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary),
            ),
          ),
        ],
      ),
    );
  }
}
