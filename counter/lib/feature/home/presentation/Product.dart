import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../../../core/network/dio_helper.dart';
import '../../../core/network/endpoints.dart';
import '../../cart/data/model/product_cart_model.dart';
import '../../cart/logic/cart_cubit.dart';
import '../../wishlist/logic/wishlist_cubit.dart';
import '../../home/presentation/product_details_screen.dart';

class ProductList extends StatefulWidget {
  final Axis scrollDirection;

  ProductList({required this.scrollDirection});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<dynamic> products = [];
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: isLoading
          ? Center(child: CircularProgressIndicator())
          : hasError
          ? Center(child: Text("Failed to load products!"))
          : ListView.builder(
        scrollDirection: widget.scrollDirection,
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
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
              value: BlocProvider.of<WishlistCubit>(context),
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
        width: 170,
        margin: EdgeInsets.only(left: 10),
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
                height: 120,
                width: double.infinity,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 120,
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
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12), maxLines: 2, overflow: TextOverflow.ellipsis),
                  SizedBox(height: 4),
                  Text(price, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue)),
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
