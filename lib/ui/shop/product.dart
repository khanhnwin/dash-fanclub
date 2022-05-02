import 'dart:math';

import 'package:dash_fanclub_app/ui/shared/whitespace.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get_it/get_it.dart';

import '../../api/bag.dart';
import '../../api/shop_inventory.dart';
import '../../api/bag_item.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../api/bag.dart';
import 'package:get_it/get_it.dart';
import '../shared/shared.dart';
import '../../api/api.dart';

GetIt getIt = GetIt.instance;

class ProductPage extends StatefulWidget {
  final Product product;

  const ProductPage({Key? key, required this.product}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late String? _size;
  int quantity = 1;
  int quantityAvailableForSize = 0;

  @override
  void initState() {
    super.initState();
    _size = widget.product.sizes.keys.first;
  }

  void setSize(ProductSize size) {
    setState(() {
      _size = size.name;
      int quantityAvailable = widget.product.sizes[_size] ?? 1;
      quantityAvailableForSize = min(quantityAvailable, 7);
    });
  }

  void setQuantity(int newQuantity) {
    setState(() {
      quantity = newQuantity;
    });
  }

  void setColor(ProductColor color) {}

  void addToBag() {
    print("Add to bag!");
    String? localSize = _size;

    print(quantity);
    print(localSize);

    if (quantity == 0 || localSize == null) {
      return;
    }

    BagItem item = BagItem(widget.product, quantity, localSize);

    print(BagItem);

    getIt<Bag>().add(item);

    print("Added ${widget.product.name} to bag!");
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    int quantityAvailable = widget.product.sizes[_size] ?? 1;
    quantityAvailableForSize = min(quantityAvailable, 7);

    return WillPopScope(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Stack(
            children: [
              ListView(
                children: [
                  ProductImageCarousel(
                    images: widget.product.images,
                  ),
                  Center(
                    child: Text(
                      widget.product.name,
                      style: GoogleFonts.patuaOne(
                        fontSize: 24,
                      ),
                    ),
                  ),
                  const Whitespace(height: 5),
                  Center(
                    child: Text(
                      "\$${widget.product.price.toString()}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Center(
                    child: SingleOptionPicker<ProductSize>(
                      options: widget.product.sizes.map<ProductSize, int>(
                          (String name, int quantity) =>
                              MapEntry<ProductSize, int>(
                                  ProductSize(name), quantity)),
                      setSingleOption: setSize,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Center(
                    child: SingleOptionPicker<ProductColor>(
                      options: const {
                        ProductColor(name: "DashBlue", color: Colors.blue): 5,
                        ProductColor(name: "Black", color: Colors.black): 9,
                        ProductColor(name: "Pink", color: Colors.pink): 10,
                        ProductColor(name: "Orange", color: Colors.orange): 4,
                      },
                      setSingleOption: setColor,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: Text(
                      widget.product.description,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 100,
                  child: Column(
                    children: [
                      const Divider(),
                      Row(
                        children: [
                          const Whitespace(width: 10),
                          QuantityPicker(
                              quantity: quantity,
                              maxQuantity: quantityAvailableForSize,
                              onChanged: setQuantity),
                          const Whitespace(
                            width: 20,
                          ),
                          AddToBagButton(onTap: addToBag),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Baseline(
                  baseline: MediaQuery.of(context).viewPadding.top + 15,
                  baselineType: TextBaseline.alphabetic,
                  child: IconButton(
                    onPressed: () => {Navigator.of(context).pop()},
                    icon: const Icon(Icons.arrow_back),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onWillPop: () async => false,
    );
  }
}

class ProductImageCarousel extends StatelessWidget {
  const ProductImageCarousel({required this.images, Key? key})
      : super(key: key);

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 1 / 1,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
      ),
      items: images.map((String image) {
        return Builder(
          builder: (BuildContext context) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Hero(
                tag: image,
                child: Image(image: AssetImage(image), fit: BoxFit.fitWidth),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

class QuantityPicker extends StatelessWidget {
  const QuantityPicker(
      {required this.quantity,
      required this.maxQuantity,
      required this.onChanged,
      this.minQuantity = 0,
      Key? key})
      : super(key: key);

  final int quantity;
  final int minQuantity;
  final int maxQuantity;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    List<int> quantityDropDownOptions = [];

    for (int i = 0; i < maxQuantity + 1; i++) {
      quantityDropDownOptions.add(i);
    }

    print(quantityDropDownOptions);
    print(quantity);

    return DropdownButton<int>(
      items: quantityDropDownOptions.map<DropdownMenuItem<int>>((int option) {
        return DropdownMenuItem<int>(
            child: Text(option.toString()), value: option);
      }).toList(),
      onChanged: (int? newValue) {
        if (newValue is int) {
          onChanged(newValue);
        }
      },
      value: quantity,
    );
  }
}

class AddToBagButton extends StatelessWidget {
  const AddToBagButton({required this.onTap, Key? key}) : super(key: key);

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        child: const Text("Add to Bag"),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              Theme.of(context).colorScheme.primary),
        ),
        onPressed: () => {onTap()},
      ),
    );
  }
}
