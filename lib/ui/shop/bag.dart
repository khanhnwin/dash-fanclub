import 'dart:developer';

import 'package:flutter/material.dart';
import '../../api/bag.dart';
import '../../api/bag_item.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

class BagPage extends StatefulWidget {
  const BagPage({Key? key}) : super(key: key);

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
    super.initState();

    for (int i = 0; i < getIt<Bag>().items.length; i++) {
      subtotal += getIt<Bag>().items[i].item.price;
    }

    shipping =
        12; // lol let's say it's a flat rate for now, assuming there's an api for this too

    tax = subtotal *
        .0825; // Assuming the location is TX. There should be a separate API to calculate tax, theoretically.

    total = subtotal;
    total += shipping;
    total += tax;
  }

  void checkout() {
    Navigator.pop(context, true);
    getIt<Bag>().clear();
    log("Checkout was a success, bag cleared!");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Baseline(
            baseline: MediaQuery.of(context).viewPadding.top + 25,
            baselineType: TextBaseline.alphabetic,
            child: Column(
              children: [
                const Text(
                  "Shopping Bag",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "${getIt<Bag>().items.length} items",
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                const Divider(),
                const BagList(),
                const Divider(),
                const SizedBox(height: 10),
                CostCalculations(
                    subtotal: subtotal,
                    shipping: shipping,
                    tax: tax,
                    total: total),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: CheckoutButton(onTap: checkout),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BagList extends StatelessWidget {
  const BagList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<BagItem> items = getIt<Bag>().items;

    return SizedBox(
      height: 530,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ItemCard(
              name: items[index].item.name,
              image: items[index].item.firstImage,
              size: items[index].size,
              quantity: items[index].quantity,
              price: items[index].item.price);
        },
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  const ItemCard(
      {required this.image,
      required this.name,
      required this.size,
      required this.price,
      required this.quantity,
      Key? key})
      : super(key: key);

  final String image;
  final String name;
  final String size;
  final int quantity;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(children: [
      SizedBox(
        width: 125,
        height: 125,
        child: Image(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary),
              ),
              const SizedBox(height: 10),
              Text(
                "Size: ${size.toUpperCase()}",
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "Qty: ${quantity.toString()}",
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(
                    width: 125,
                  ),
                  Text(
                    "\$${price.toString()}",
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
  }
}

class CostCalculations extends StatelessWidget {
  const CostCalculations(
      {this.subtotal = 0,
      this.shipping = 0,
      this.tax = 0,
      this.total = 0,
      Key? key})
      : super(key: key);

  final double subtotal;
  final double shipping;
  final double tax;
  final double total;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
      ],
    );
  }
}

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({required this.onTap, Key? key}) : super(key: key);

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: const Text(
        "Checkout",
      ),
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Theme.of(context).colorScheme.primary)),
    );
  }
}
