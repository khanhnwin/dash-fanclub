import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../api/shop_inventory.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductPage extends StatefulWidget {
  final Product product;

  const ProductPage({Key? key, required this.product}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late String size = widget.product.defaultSize;
  List<bool> _sizeSelector = List.generate(6, (_) => false);
  int quantity = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _sizeSelector = List.generate(widget.product.sizes.length, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: MaterialApp(
        home: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Stack(
              children: [
                ListView(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        aspectRatio: 1 / 1,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                      ),
                      items: widget.product.images.map((String image) {
                        return Builder(
                          builder: (BuildContext context) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Hero(
                                tag: image,
                                child: Image(
                                    image: AssetImage(image),
                                    fit: BoxFit.fitWidth),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    Center(
                      child: Text(
                        widget.product.name,
                        style: GoogleFonts.patuaOne(
                          fontSize: 24,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
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
                      child: Expanded(
                        child: ToggleButtons(
                          children: [
                            Text(
                              "xs".toUpperCase(),
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                            Text(
                              "s".toUpperCase(),
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                            Text(
                              "m".toUpperCase(),
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                            Text(
                              "l".toUpperCase(),
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                            Text(
                              "xl".toUpperCase(),
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                            Text(
                              "xxl".toUpperCase(),
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                          ],
                          isSelected: _sizeSelector,
                          onPressed: (int index) {
                            setState(() {
                              _sizeSelector = List.generate(
                                  widget.product.sizes.length, (_) => false);
                              _sizeSelector[index] = !_sizeSelector[index];
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 5),
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
                            const SizedBox(
                              width: 10,
                            ),
                            DropdownButton<String>(
                              items: [1, 2, 3, 4, 5, 6, 7]
                                  .map<DropdownMenuItem<String>>((int value) {
                                return DropdownMenuItem<String>(
                                    child: Text(value.toString().toUpperCase()),
                                    value: value.toString());
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  if (newValue is String) {
                                    quantity = int.parse(newValue);
                                  }
                                });
                              },
                              value: quantity.toString(),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                child: Text("Add to Bag"),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<
                                            Color>(
                                        Theme.of(context).colorScheme.primary)),
                                onPressed: () {
                                  print("Added ${widget.product.name} to bag!");
                                  Navigator.of(context).pop({
                                    "product": widget.product,
                                    "size": size
                                  });
                                },
                              ),
                            ),
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
                      onPressed: () => {Navigator.of(context).pop({})},
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async => false,
    );
  }
}
