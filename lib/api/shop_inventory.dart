class ShopInventory {
  final Map<String, Product> products = {
    "0": Product(
      productId: "0",
      name: "Dash Holiday Sweater",
      description:
          "Keep warm and rep Dash at your next holiday party with this wonderfully cozy Dash holiday sweater.",
      price: 49,
      sizes: {"xs": 5, "s": 3, "m": 8, "l": 5, "xl": 3, "xxl": 3},
      images: [
        "assets/images/shop/sweater-front.png",
        "assets/images/shop/sweater-back.png"
      ],
    ),
    "1": Product(
        productId: "1",
        name: "Dash Plushie",
        description:
            "She's fuzzy, she's nice. She'll be your rubber duck! Throw her at someone to get their attention. (Jk, don't do that.) Get your very own Dash plushie today!",
        price: 36,
        sizes: {"one-size": 98},
        images: ["assets/images/shop/dash-plushie.png"]),
    "2": Product(
      productId: "2",
      name: "Dash T-Shirt",
      description:
          "Rock your Dash dedication for everyone to see with this soft and comfortable Dash t-shirt.",
      price: 29,
      sizes: {"xs": 7, "s": 10, "m": 12, "l": 11, "xl": 8, "xxl": 6},
      images: [
        "assets/images/shop/t-shirt.png",
        "assets/images/shop/t-shirt-back.png"
      ],
    ),
  };

  Map<String, Product> getAllProducts() {
    return products;
  }

  Product? getProduct(String productId) {
    Product? retrievedProduct = products[productId];

    return retrievedProduct;
  }
}

class Product {
  late String _productId;
  late String _name;
  late String _description;
  late int _price;
  late Map<String, int> _sizes;
  late List<String> _images;

  Product(
      {required String productId,
      required String name,
      required String description,
      required int price,
      required Map<String, int> sizes,
      required List<String> images}) {
    _productId = productId;
    _name = name;
    _description = description;
    _price = price;
    _sizes = sizes;
    _images = images;
  }

  Map<String, Object> get productValues {
    Map<String, Object> product = {};

    product["productId"] = _productId;
    product["name"] = _name;
    product["description"] = _description;
    product["price"] = _price;
    product["sizes"] = _sizes;
    product["images"] = _images;

    return product;
  }

  String get productId {
    return _productId;
  }

  String get name {
    return _name;
  }

  String get description {
    return _description;
  }

  int get price {
    return _price;
  }

  Map<String, int> get sizes {
    return _sizes;
  }

  String get defaultSize {
    return _sizes.keys.first;
  }

  List<String> get images {
    return _images;
  }

  String get firstImage {
    return _images[0];
  }
}
