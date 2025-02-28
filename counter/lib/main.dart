import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:counter/feature/cart/logic/cart_cubit.dart';
import 'package:counter/feature/intro/splash_screen.dart';
import 'package:counter/core/db/cache/cache_helper.dart';
import 'package:counter/core/db/local_db/local_db_helper.dart';
import 'package:counter/core/network/dio_helper.dart';
import 'feature/wishlist/logic/wishlist_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await SQLHelper.initDb();
  await CacheHelper.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CartCubit()..getCartData()), // ✅ CartCubit
        BlocProvider(create: (context) => WishlistCubit()), // ✅ WishlistCubit (Global)
      ],
      child: ScreenUtilInit(
        designSize: Size(375, 812), // ✅ Standard design size
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
          );
        },
      ),
    ),
  );
}
