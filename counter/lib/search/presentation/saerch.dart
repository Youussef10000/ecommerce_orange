import 'package:counter/core/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../../core/network/dio_helper.dart';
import '../../../core/network/endpoints.dart';
import '../../feature/home/presentation/product_details_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<dynamic> allProducts = []; // Stores all products
  List<dynamic> filteredProducts = []; // Stores filtered products
  bool isLoading = true;
  bool hasError = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchProducts();
    searchController.addListener(_filterProducts);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // Fetch products from API
  Future<void> fetchProducts() async {
    try {
      var response = await DioHelper.getData(url: Endpoints.productsEndpoint);
      if (response.statusCode == 200) {
        setState(() {
          allProducts = response.data;
          filteredProducts = allProducts; // Initially show all products
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

  // Filter products based on search input
  void _filterProducts() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredProducts = allProducts.where((product) {
        return product["title"].toString().toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // Search Bar
            Padding(
              padding: EdgeInsets.all(10),
              child:
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Search for a product...",
                  prefixIcon: Icon(Icons.search, color: AppColor.buttonColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey), // Set the default border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey), // Set the same color for focused state
                  ),
                ),
              ),
            ),

            // Product List (Filtered)
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : hasError
                  ? Center(child: Text("Failed to load products!"))
                  : filteredProducts.isEmpty
                  ? Center(child: Text("No products found"))
                  : ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return _buildProductCard(
                    product["title"] ?? "No Title",
                    "\$${product["price"] ?? "0"}",
                    product["image"] ?? "",
                    product["description"] ?? "No Description Available",
                    context,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(
      String title, String price, String imageUrl, String description, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to Product Details
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
              title: title,
              price: price,
              imageUrl: imageUrl,
              description: description,
            ),
          ),
        );
      },
      child: Card(
        elevation: 3,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        child: ListTile(
          leading: Image.network(
            imageUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 60,
                height: 60,
                color: Colors.grey[300],
                child: Icon(Icons.image_not_supported, color: Colors.grey),
              );
            },
          ),
          title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
          subtitle: Text(price, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
          trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ),
      ),
    );
  }
}
