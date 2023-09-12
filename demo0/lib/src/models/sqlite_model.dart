class SqliteModel {
  String name;
  double price;
  double stock;

  SqliteModel(this.name, this.price, this.stock);

  @override
  String toString() {
    return "$name, $price, $stock";
  }
}
