import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/dio_helper.dart';
import '../../../core/network/endpoints.dart';
import '../../home/presentation/product_details_screen.dart';
import '../../wishlist/logic/wishlist_cubit.dart';

class ProductGrid extends StatefulWidget {
  final String category;

  ProductGrid({required this.category});

  @override
  _ProductGridState createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  List<dynamic> products = [];
  List<dynamic> filteredProducts = [];
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      var response = await DioHelper.getData(url: Endpoints.productsEndpoint);
      if (response.statusCode == 200) {
        setState(() {
          products = response.data;
          filterProducts();
          isLoading = false;
          hasError = false;
        });
      } else {
        setState(() {
          isLoading = false;
          hasError = true;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        hasError = true;
      });
    }
  }

  void filterProducts() {
    setState(() {
      filteredProducts = products.where((product) {
        return widget.category.isEmpty ||
            product["category"].toString().toLowerCase() == widget.category.toLowerCase();
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      child: isLoading
          ? Center(child: CircularProgressIndicator())
          : hasError
          ? Center(child: Text("Failed to load products!"))
          : Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: GridView.builder(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 280,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.75,
          ),
          itemCount: filteredProducts.length,
          itemBuilder: (context, index) {
            final product = filteredProducts[index];
            return _buildProductCard(
              product["title"] ?? "No Title",
              "\$${product["price"] ?? "0"}",
              product["image"] ?? "",
              product["category"] ?? "Category",
              product["description"] ?? "No Description Available",
              context,
            );
          },
        ),
      ),
    );
  }

  Widget _buildProductCard(
      String title, String price, String imageUrl, String category, String description, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: context.read<WishlistCubit>(), // Ensure correct Bloc context
              child: ProductDetailScreen(
                title: title,
                price: price,
                imageUrl: imageUrl,
                description: description,
              ),
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.network(
                imageUrl,
                height: 160,
                width: double.infinity,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 160,
                    color: Colors.grey[300],
                    child: Center(child: Icon(Icons.image_not_supported, color: Colors.grey)),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    price,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(category, style: TextStyle(fontSize: 10, color: Colors.orange)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
