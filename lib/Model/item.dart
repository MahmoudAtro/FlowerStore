class Item {
  String imageurl;
  double price;
  int quantity = 1;
  Item({required this.imageurl, required this.price});
}

List<Item> product = [
  Item(imageurl: '1.webp', price: 10),
  Item(imageurl: '1.webp', price: 12.99),
  Item(imageurl: '1.webp', price: 14.5),
  Item(imageurl: '1.webp', price: 13),
];
