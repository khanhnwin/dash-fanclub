class ShopInventory {
  final Map<String, Product> products = {
    "0": Product(
      productId: "0",
      name: "Dash Holiday Sweater",
      description:
          "Keep warm and rep Dash at your next holiday party with this wonderfully cozy Dash holiday sweater.",
      price: 49,
      sizes: {
        "x-small": 5,
        "small": 3,
        "medium": 8,
        "large": 5,
        "extra-large": 3,
        "extra-extra large": 3
      },
      images: [
        "assets/images/shop/sweater-front.png",
        "assets/images/shop/sweater-back.png"
      ],
    ),
    "1": Product(
        productId: "1",
        name: "Dash Plushie",
        description: "",
        price: 36,
        sizes: {"one-size": 98},
        images: ["assets/images/shop/dash-plushie.png"]),
    "2": Product(
      productId: "2",
      name: "Dash T-Shirt",
      description: "",
      price: 29,
      sizes: {
        "x-small": 7,
        "small": 10,
        "medium": 12,
        "large": 11,
        "extra-large": 8,
        "extra-extra large": 6
      },
      images: [
        "assets/images/shop/t-shirt.png",
        "assets/images/shop/t-shirt-back.png"
      ],
    ),
  };

  /* "0": {
      "name": "Dash Holiday Sweater",
      "description":
          "Keep warm and rep Dash at your next holiday party with this wonderfully cozy Dash holiday sweater.",
      "price": 49,
      "sizes": {
        "x-small": 5,
        "small": 3,
        "medium": 8,
        "large": 5,
        "extra-large": 3,
        "extra-extra large": 3
      },
      "images": [
        "assets/images/shop/sweater-front.png",
        "assets/images/shop/sweater-back.png"
      ],
    },
    "1": {
      "name": "Dash Plushie",
      "description": "",
      "price": 36,
      "sizes": {"one-size": 98},
      "images": ["assets/images/shop/dash-plushie.png"]
    },
    "2": {
      "name": "Dash T-Shirt",
      "description": "",
      "price": 29,
      "sizes": {
        "x-small": 7,
        "small": 10,
        "medium": 12,
        "large": 11,
        "extra-large": 8,
        "extra-extra large": 6
      },
      "images": [
        "assets/images/shop/t-shirt.png",
        "assets/images/shop/t-shirt-back.png"
      ],
    }, */

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

  List<String> get images {
    return _images;
  }

  String get firstImage {
    return _images[0];
  }
}
