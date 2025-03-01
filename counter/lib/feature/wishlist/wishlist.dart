import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cart/data/model/product_cart_model.dart';
import '../home/presentation/home_screen.dart';
import 'logic/wishlist_cubit.dart';

class WishlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistCubit, WishlistState>(
      builder: (context, state) {
        final wishlist = context.read<WishlistCubit>().wishlist;

        return Scaffold(
          appBar: AppBar(title: Text("Wishlist",),
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




          body: wishlist.isNotEmpty
              ? ListView.builder(
            itemCount: wishlist.length,
            itemBuilder: (context, index) {
              final product = wishlist[index];

              return ListTile(
                leading: Image.network(product.image ?? "", width: 50, height: 50, fit: BoxFit.cover),
                title: Text(product.title ?? "No Title"),
                subtitle: Text("\$${product.price?.toStringAsFixed(2) ?? "0.00"}"),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    context.read<WishlistCubit>().toggleWishlist(product);
                  },
                ),
              );
            },
          )
              : Center(child: Text("No products in wishlist!")),
        );
      },
    );
  }
}
