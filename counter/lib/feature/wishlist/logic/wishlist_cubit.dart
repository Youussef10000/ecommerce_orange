import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../cart/data/model/product_cart_model.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(WishlistInitial());

  List<ProductCartModel> wishlist = []; // Stores wishlist products

  void toggleWishlist(ProductCartModel product) {
    if (wishlist.any((item) => item.id == product.id)) {
      wishlist.removeWhere((item) => item.id == product.id);
      emit(WishlistRemoved(product));
    } else {
      wishlist.add(product);
      emit(WishlistAdded(product));
    }
  }
}
