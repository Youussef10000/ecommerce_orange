import 'package:counter/core/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cart/data/model/product_cart_model.dart';
import '../../cart/logic/cart_cubit.dart';
import '../../cart/presentation/cart_screen.dart';
import '../../order/Checkout_Screen.dart';
import '../../wishlist/logic/wishlist_cubit.dart';
import 'Product.dart';

class ProductDetailScreen extends StatefulWidget {
  final String title;
  final String price;
  final String imageUrl;
  final String description;

  ProductDetailScreen({
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.description,
  });

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;
  String selectedColor = "";

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<CartCubit>();
    final wishlistCubit = context.watch<WishlistCubit>();
    bool isFavorite = wishlistCubit.wishlist.any((item) => item.id == widget.title);

    double basePrice = double.tryParse(widget.price.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0;
    double productPrice = basePrice * quantity;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.black,
            ),
            onPressed: () {
              final product = ProductCartModel(
                id: widget.title,
                title: widget.title,
                price: productPrice,
                description: widget.description,
                image: widget.imageUrl,
                quantity: quantity,
              );

              wishlistCubit.toggleWishlist(product);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isFavorite ? "Removed from Wishlist!" : "Added to Wishlist!"),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "NEW ARRIVAL",
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),

                  Center(
                    child: Text(
                      "\$${productPrice.toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                  ),
                  SizedBox(height: 10),

                  Center(
                    child: Image.network(
                      widget.imageUrl,
                      height: 250,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 250,
                          color: Colors.grey[300],
                          child: Center(child: Icon(Icons.image_not_supported, color: Colors.grey)),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10),



                  Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _colorOption(Color(0xffA6A5AA), "Grey"),
                            SizedBox(width: 10),
                            _colorOption(Color(0xffE8E8EA), "White"),
                            SizedBox(width: 10),
                            _colorOption(Color(0xffF2E0CC), "Beige"),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          selectedColor, // ✅ Displays the selected color name
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),

                  Divider(height: 20, thickness: 2.5),
                  SizedBox(height: 15),
                  Text(
                    "Product Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),
                  Text(
                    widget.description,
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  SizedBox(height: 50),
                  Text(
                    "Product Related",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 15,),
                  //
                  SizedBox(
                    height: 230,
                    width: MediaQuery.of(context).size.width - 50,
                    child: ProductList(scrollDirection: Axis.horizontal),
                  ),
                  SizedBox(height: 15,),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          cartCubit.addProduct(
                            ProductCartModel(
                              id: widget.title,
                              title: widget.title,
                              price: productPrice,
                              description: widget.description,
                              image: widget.imageUrl,
                              quantity: quantity,
                            ),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Added to Cart!"),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey.shade200,
                          child: Icon(Icons.shopping_cart, color: AppColor.buttonColor),
                        ),
                      ),
                      SizedBox(width: 15),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.buttonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 70, vertical: 12),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CartScreen()), // ✅ Wrapped in MaterialPageRoute
                          );
                        },
                        child: Text(
                          "Go to Cart",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),

                    ],
                  ),

                  SizedBox(height: 50),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _colorOption(Color color, String colorName) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = colorName;
        });
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: selectedColor == colorName ? Colors.black : Colors.transparent, width: 2),
        ),
      ),
    );
  }
}
