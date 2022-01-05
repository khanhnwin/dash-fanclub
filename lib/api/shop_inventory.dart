class ShopInventory {
  final products = {
    "0": {
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
    },
  };

  Map<String, Map<String, Object>> getAllProducts() {
    return products;
  }

  Map<String, Object> getProduct(String productId) {
    Map<String, Object>? product = products[productId];

    if (product == null) {
      return {};
    }

    return product;
  }
}
