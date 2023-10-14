import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:grocery_app/bloc/category_bloc.dart/category_bloc.dart';
import 'package:grocery_app/bloc/product_bloc.dart/product_bloc.dart';
import 'package:grocery_app/bloc/single_product_bloc/single_product_bloc.dart';
import 'package:grocery_app/constants/app_routes.dart';
import 'package:grocery_app/constants/constants.dart';
import 'package:grocery_app/repository/auth_repository.dart';
import 'package:grocery_app/repository/category_repository.dart';
import 'package:grocery_app/repository/product_repository.dart';
import 'package:grocery_app/screens/single_product_screen.dart';
import 'package:grocery_app/screens/thank_you_screen.dart';
import 'package:grocery_app/screens/home_screen.dart';
import 'package:grocery_app/screens/login_screen.dart';
import 'package:grocery_app/screens/splash_screen.dart';

void main() {
  final AuthRepository authRepository = AuthRepository();
  final CategoryRepository categoryRepository = CategoryRepository();
  final ProductRepository productRepository = ProductRepository();
  runApp(MyApp(
      authRepository: authRepository,
      categoryRepository: categoryRepository,
      productRepository: productRepository));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  final CategoryRepository categoryRepository;
  final ProductRepository productRepository;

  const MyApp({
    super.key,
    required this.authRepository,
    required this.categoryRepository,
    required this.productRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authRepository),
        RepositoryProvider.value(value: productRepository),
        RepositoryProvider.value(value: categoryRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(authRepository: authRepository),
          ),
          BlocProvider(
            create: (context) =>
                CategoryBloc(categoryRepository: categoryRepository),
          ),
          BlocProvider(
            create: (context) =>
                ProductBloc(productRepository: productRepository),
          ),
          BlocProvider(
            create: (context) =>
                SingleProductBloc(productRepository: productRepository),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            fontFamily: "Poppins",
            pageTransitionsTheme: const PageTransitionsTheme(builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            }),
            primarySwatch: MaterialColor(
              primaryColor.value,
              <int, Color>{
                50: primaryColor.withOpacity(0.1),
                100: primaryColor.withOpacity(0.2),
                200: primaryColor.withOpacity(0.3),
                300: primaryColor.withOpacity(0.4),
                400: primaryColor.withOpacity(0.5),
                500: primaryColor.withOpacity(0.6),
                600: primaryColor.withOpacity(0.7),
                700: primaryColor.withOpacity(0.8),
                800: primaryColor.withOpacity(0.9),
                900: primaryColor.withOpacity(1.0),
              },
            ),
          ),
          home: const SplashScreen(),
          routes: {
            AppRoutes.home: (context) => const HomeScreen(),
            AppRoutes.login: (context) => const LoginScreen(),
            AppRoutes.thankYou: (context) => const ThankYouScreen(),
            AppRoutes.singleProduct: (context) => SingleProductScreen(
                  ModalRoute.of(context)!.settings.arguments
                      as Map<String, dynamic>,
                )
          },
        ),
      ),
    );
  }
}
