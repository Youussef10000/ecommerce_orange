import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/db/local_db/local_db_helper.dart';
import '../data/model/product_cart_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  double totalPrice = 0;
  List<ProductCartModel> products = [];

  Future<void> getCartData() async {
    emit(CartLoading());
    try {
      final data = await SQLHelper.get();
      products = data.map((e) => ProductCartModel.fromJson(e)).toList();

      calculateTotalPrice();
      emit(CartLoaded(products));

    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> addProduct(ProductCartModel newProduct) async {
    emit(CartLoading());

    try {
      await SQLHelper.add(
        newProduct.id!,
        newProduct.title!,
        newProduct.description!,
        newProduct.image!,
        newProduct.quantity!,
        newProduct.price!.toDouble(),
      );

      await getCartData();

      emit(CartProductAdded());
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> deleteProduct(String id, int index) async {
    emit(CartLoading());
    try {
      await SQLHelper.delete(id);
      products.removeAt(index);
      calculateTotalPrice();
      emit(CartLoaded(products));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  void calculateTotalPrice() {
    totalPrice = 0;
    for (var product in products) {
      totalPrice += product.quantity! * product.price!.toDouble();
    }
  }
}
