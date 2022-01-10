import 'package:dash_fanclub_app/api/bag_item.dart';
import 'package:flutter/material.dart';
import '../../api/shop_inventory.dart';
import '../../api/bag.dart';
import './product.dart';
import './bag.dart';

class DashShop extends StatefulWidget {
  const DashShop({Key? key}) : super(key: key);

  @override
  _DashShopState createState() => _DashShopState();
}

class _DashShopState extends State<DashShop> {
  final ShopInventory inventoryManager = ShopInventory();
  late Map<String, Product> inventory;
  late Product selectedProduct;
  final Bag bag = Bag();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inventory = inventoryManager.getAllProducts();
  }

  void applyFilter() {}

  void _openProduct(BuildContext context, Product item) async {
    // Push Product page on top of stack
    final purchased = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProductPage(product: item)));

    if (purchased is BagItem) {
      bag.add(purchased);
    }

    bag.outputBag();
  }

  void _openBag(BuildContext context) async {
    final checkout = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => BagPage(bag: bag)));

    // if checkout is true, then clear bag?
    if (checkout is bool) {
      if (checkout == true) {
        bag.clear();
        print("Checkout was a sucess, bag cleared!");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> productTiles = [];

    inventory.forEach((String productId, Product item) {
      print(item.productValues);
      productTiles.add(
        GestureDetector(
          onTap: () {
            _openProduct(context, item);
          },
          child: Card(
            child: Column(
              children: [
                SizedBox(
                  width: 500,
                  height: 175,
                  child: Hero(
                    tag: item.firstImage,
                    child: Image(
                      image: AssetImage(item.firstImage),
                      fit: BoxFit.cover,
                    ),
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
        ),
      );
    });

    return Stack(
      children: [
        Column(
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
            /*Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 0, 5),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text("${inventory.length.toString()} items"),
          ),
        ),*/
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
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.all(25),
            child: FloatingActionButton(
              child: Icon(Icons.shopping_bag_sharp, color: Colors.white),
              onPressed: () {
                _openBag(context);
              },
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ],
    );
  }
}
