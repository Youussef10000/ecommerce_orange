import 'package:counter/core/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../order/order_Screen.dart';
import '../logic/cart_cubit.dart';
import '../../home/presentation/home_screen.dart';
import '../../cart/data/model/product_cart_model.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..getCartData(),
      child: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cartCubit = context.watch<CartCubit>();

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text('Cart'),
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
              ),
            ),
            body: state is CartLoading
                ? Center(child: CircularProgressIndicator())
                : cartCubit.products.isNotEmpty
                ? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartCubit.products.length,
                    itemBuilder: (context, index) {
                      final product = cartCubit.products[index];

                      return Card(
                        elevation: 3,
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              product.image ?? "",
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.image_not_supported, size: 50, color: Colors.grey);
                              },
                            ),
                          ),
                          title: Text(
                            product.title ?? "No Title",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "\$${product.price?.toStringAsFixed(2) ?? "0.00"}",
                                style: TextStyle(fontSize: 14, color: Colors.blue, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5),

                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove, color: AppColor.buttonColor),
                                    onPressed: () {
                                      int currentQuantity = product.quantity ?? 1;
                                      if (currentQuantity > 1) {
                                        cartCubit.updateProductQuantity(product.id!, currentQuantity - 1);
                                      } else {
                                        cartCubit.deleteProduct(product.id!, index);
                                      }
                                    },
                                  ),
                                  Text(
                                    "${product.quantity ?? 1}",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.add, color: AppColor.buttonColor),
                                    onPressed: () {
                                      cartCubit.updateProductQuantity(product.id!, (product.quantity ?? 1) + 1);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              cartCubit.deleteProduct(product.id!, index);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Total Price: \$${cartCubit.totalPrice.toStringAsFixed(2)}',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.buttonColor,
                          padding: EdgeInsets.symmetric(vertical: 13, horizontal: 65),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),

                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderScreen(cartProducts: cartCubit.products),
                            ),
                          );
                        },

                        child: Text(
                          "Checkout",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
                : Center(child: Text("No Products in Cart", style: TextStyle(fontSize: 16))),
          );
        },
      ),
    );
  }
}
