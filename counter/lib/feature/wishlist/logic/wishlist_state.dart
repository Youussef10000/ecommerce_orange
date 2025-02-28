part of 'wishlist_cubit.dart';

@immutable
abstract class WishlistState {}

class WishlistInitial extends WishlistState {}

class WishlistAdded extends WishlistState {
  final ProductCartModel product;
  WishlistAdded(this.product);
}

class WishlistRemoved extends WishlistState {
  final ProductCartModel product;
  WishlistRemoved(this.product);
}
