import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/bloc/category_bloc.dart/category_bloc.dart';
import 'package:grocery_app/bloc/category_bloc.dart/category_state.dart';
import 'package:grocery_app/constants/app_routes.dart';
import 'package:grocery_app/constants/constants.dart';

import '../bloc/category_bloc.dart/category_event.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<CategoryBloc>(context).add(CategoryDataLoad());
  }

  Widget buildCategory(String path, String name) {
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

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () => Navigator.of(context)
                            .pushNamedAndRemoveUntil(
                                AppRoutes.home, (route) => false),
                        child: const Icon(Icons.arrow_back)),
                    const Text(
                      "Categories",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
        BlocConsumer<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state is CategoryLoading) {
                return Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    ),
                  ),
                );
              }
              if (state is CategoryLoadSuccess) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  height: MediaQuery.of(context).size.height * .85,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 3,
                            // childAspectRatio: 9 / 12,
                            mainAxisSpacing: 2,
                            crossAxisCount: 2),
                    itemBuilder: (BuildContext context, int index) {
                      return buildCategory(
                        state.categories[index].primaryImage,
                        state.categories[index].name,
                      );
                    },
                    itemCount: state.categories.length,
                  ),
                );
              }
              if (state is CategoryLoadFailure) {
                return Text('data failed to load');
              }

              return Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(),
                    ),
                  ],
                ),
              );
            },
            listener: (context, state) {})
      ],
    );
  }
}
