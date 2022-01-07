import 'package:flutter/material.dart';
import '../../api/bag.dart';
import '../../api/bag_item.dart';
import '../../api/shop_inventory.dart';

class BagPage extends StatefulWidget {
  final Bag bag;

  const BagPage({Key? key, required this.bag}) : super(key: key);

  @override
  _BagPageState createState() => _BagPageState();
}

class _BagPageState extends State<BagPage> {
  double subtotal = 0;
  double shipping = 0;
  double tax = 0;
  double total = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (int i = 0; i < widget.bag.items.length; i++) {
      subtotal += widget.bag.items[i].item.price;
    }

    shipping =
        12; // lol let's say it's a flat rate for now, assuming there's an api for this too

    tax = subtotal *
        .0825; // Assuming the location is TX. There should be a separate API to calculate tax, theoretically.

    total = subtotal;
    total += shipping;
    total += tax;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Baseline(
            baseline: MediaQuery.of(context).viewPadding.top + 15,
            baselineType: TextBaseline.alphabetic,
            child: Column(
              children: [
                Text("Shopping Bag"),
                Text("${widget.bag.items.length} items"),
                BagList(bag: widget.bag),
                Text("Subtotal \$${subtotal.toStringAsFixed(2)}"),
                Text("Estimated Shipping \$${shipping.toStringAsFixed(2)}"),
                Text("Estimated Tax \$${tax.toStringAsFixed(2)}"),
                Text("Total \$${total.toStringAsFixed(2)}"),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Proceed to checkout"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BagList extends StatefulWidget {
  final Bag bag;

  const BagList({Key? key, required this.bag}) : super(key: key);

  @override
  _BagListState createState() => _BagListState();
}

class _BagListState extends State<BagList> {
  late List<BagItem> items = widget.bag.items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Card(
            child: Row(children: [
          SizedBox(
            width: 125,
            height: 125,
            child: Image(
              image: AssetImage(items[index].item.firstImage),
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Text(
                  items[index].item.name,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondaryVariant),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text(
                    "Size: ${items[index].size}",
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text("Quantity: ${items[index].quantity.toString()}"),
              Text("\$${items[index].item.price.toString()}"),
            ],
          )
        ]));
      },
    );
  }
}
