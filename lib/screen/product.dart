import 'package:flutter/material.dart';
import 'package:testapk/model/product_model.dart';
import 'package:testapk/screen/product_view.dart';
import 'package:testapk/services/api_services.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ApiServices services = ApiServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Products'),
      ),
      body: FutureBuilder<List<Product>>(
        future: services.fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No products found.'));
          } else {
            List<Product> productList = snapshot.data!;
            return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.95, crossAxisCount: 2),
                          itemCount: productList.length,
                          itemBuilder: (context, index) {
            final product = productList[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductView(product: product),
                    ));
              },
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.network(
                        product.image,
                        height: 120,
                      ),
                      Text(
                        product.title,
                        maxLines: 1,
                      ),
                      Text(
                        "${product.description}",
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "Price : \$${product.price.toString()}",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            );
                          },
                        );
          }
        },
      ),
    );
  }
}
