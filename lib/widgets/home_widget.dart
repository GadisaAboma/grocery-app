import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/bloc/category_bloc.dart/category_bloc.dart';
import 'package:grocery_app/bloc/category_bloc.dart/category_event.dart';
import 'package:grocery_app/bloc/category_bloc.dart/category_state.dart';
import 'package:grocery_app/bloc/product_bloc.dart/product_bloc.dart';
import 'package:grocery_app/bloc/product_bloc.dart/product_event.dart';
import 'package:grocery_app/bloc/product_bloc.dart/product_state.dart';
import 'package:grocery_app/constants/app_routes.dart';
import 'package:grocery_app/constants/constants.dart';
import 'package:grocery_app/screens/single_product_screen.dart';

class HomeWidget extends StatefulWidget {
  Function fun;
  HomeWidget({super.key, required this.fun});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<CategoryBloc>(context).add(CategoryDataLoad());
    BlocProvider.of<ProductBloc>(context).add(ProductDataLoad());
  }

  Widget buildCategory(String path) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 218, 215, 215),
              offset: Offset(
                5.0,
                5.0,
              ),
              blurRadius: 5.0,
              spreadRadius: 1.0,
            ),
          ]),
      padding: const EdgeInsets.all(10),
      child: Image.network(
        '$imageBaseUrl$path',
        fit: BoxFit.cover,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return CircularProgressIndicator(
            color: Colors.white,
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return const Center(
              child: Icon(
            Icons.person,
            color: Colors.grey,
            size: 150,
          ));
        },
        // width: 150,
        // height: 150,
      ),
    );
  }

  Widget buildProduct(String path, String price, String name, bool isFavorite) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0), // Set the border radius
        boxShadow: const [
          BoxShadow(
            color: Colors.white, // Set the shadow color
            spreadRadius: 2, // Set the spread radius
            blurRadius: 1, // Set the blur radius
            offset: Offset(0, 3), // Set the offset
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: 60,
            child: Image.network(
              '$imageBaseUrl$path',
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return CircularProgressIndicator(
                  color: Colors.white,
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                    child: Icon(
                  Icons.person,
                  color: Colors.grey,
                  size: 150,
                ));
              },
              // width: 150,
              // height: 150,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Icon(
              Icons.favorite,
              color: isFavorite ? const Color(0xFFFF2E6C) : Colors.grey,
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  '\$$price',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 12),
                )
              ],
            ),
          ),
          Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: const Text(
                  'Add to cart',
                  style: TextStyle(color: Color(0xFFFF0000)),
                ),
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    "Good Morning",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Text(
                    "Rafatul Islam",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 10),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Categories",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          widget.fun(1);
                        },
                        icon: Icon(Icons.arrow_forward))
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  height: 110, // Provide a specific height constraint
                  child: BlocConsumer<CategoryBloc, CategoryState>(
                    builder: (context, state) {
                      if (state is CategoryLoading) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator(),
                            ),
                          ],
                        );
                      } else if (state is CategoryLoadSuccess) {
                        return ListView(
                            scrollDirection: Axis.horizontal,
                            children: state.categories
                                .map((cat) => buildCategory(cat.primaryImage))
                                .toList());
                      }

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      );
                    },
                    listener: (context, state) {
                      if (state is CategoryLoadFailure) {
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(state.reason!),
                        );
                      }
                    },
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Latest Products",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    height: 400, // Provide a specific height constraint
                    child: BlocConsumer<ProductBloc, ProductState>(
                      builder: (context, state) {
                        if (state is ProductLoading) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              SizedBox(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator(),
                              ),
                            ],
                          );
                        } else if (state is ProductLoadSuccess) {
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 3,
                                    // childAspectRatio: 9 / 12,
                                    mainAxisSpacing: 2,
                                    crossAxisCount: 2),
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () => Navigator.pushNamed(
                                    context, AppRoutes.singleProduct,
                                    arguments: {
                                      "id": state.products[index].id
                                    }),
                                child: buildProduct(
                                    state.products[index].primaryImage,
                                    state.products[index].price,
                                    state.products[index].name,
                                    state.products[index].favorite),
                              );
                            },
                            itemCount: state.products.length,
                          );
                        }

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator(),
                            ),
                          ],
                        );
                      },
                      listener: (context, state) {
                        if (state is ProductLoadFailure) {
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(state.reason!),
                          );
                        }
                      },
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
