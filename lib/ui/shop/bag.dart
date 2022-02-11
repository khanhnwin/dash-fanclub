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
            baseline: MediaQuery.of(context).viewPadding.top + 25,
            baselineType: TextBaseline.alphabetic,
            child: Column(
              children: [
                Container(
                  child: const Text(
                    "Shopping Bag",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    "${widget.bag.items.length} items",
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                const Divider(),
                BagList(bag: widget.bag),
                const Divider(),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Subtotal \t\$${subtotal.toStringAsFixed(2)}",
                    textAlign: TextAlign.right,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Estimated Shipping \t\$${shipping.toStringAsFixed(2)}",
                    textAlign: TextAlign.right,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Estimated Tax \t\$${tax.toStringAsFixed(2)}",
                    textAlign: TextAlign.right,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Total \t\$${total.toStringAsFixed(2)}",
                    textAlign: TextAlign.right,
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: const Text(
                      "Checkout",
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.primary)),
                  ),
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
    return SizedBox(
      height: 530,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
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
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      items[index].item.name,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color:
                              Theme.of(context).colorScheme.secondaryVariant),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Size: ${items[index].size.toUpperCase()}",
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "Qty: ${items[index].quantity.toString()}",
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          width: 125,
                        ),
                        Text(
                          "\$${items[index].item.price.toString()}",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ))
          ]));
        },
      ),
    );
  }
}
