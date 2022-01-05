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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 1 / 1,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                ),
                items: widget.product.images.map((String image) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.45),
                            spreadRadius: -3,
                            blurRadius: 2,
                            offset: Offset(6, 5),
                          )
                        ]),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image(
                            image: AssetImage(image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              Text(
                widget.product.name,
                style: GoogleFonts.patuaOne(
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "\$${widget.product.price.toString()}",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              Text(widget.product.description),
              const SizedBox(height: 20),
              const Divider(),
              Row(
                children: [
                  DropdownButton<String>(
                    items: widget.product.sizes.keys
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          child: Text(value), value: value);
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        size = newValue!;
                      });
                    },
                    value: size,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      child: Text("Add to Bag"),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).colorScheme.primary)),
                      onPressed: () {
                        print("Added ${widget.product.name} to bag!");
                        Navigator.of(context)
                            .pop({"product": widget.product, "size": size});
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
