class Product {
  final String barcodeNumber;
  final String title;

  Product({required this.barcodeNumber, required this.title});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      barcodeNumber: json['barcode_number'],
      title: json['title'],
    );
  }
}
