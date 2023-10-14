import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/bloc/single_product_bloc/single_product_bloc.dart';
import 'package:grocery_app/bloc/single_product_bloc/single_product_event.dart';
import 'package:grocery_app/bloc/single_product_bloc/single_product_state.dart';
import 'package:grocery_app/constants/constants.dart';

class SingleProductScreen extends StatefulWidget {
  final Map<String, dynamic>? args;
  const SingleProductScreen(this.args, {Key? key}) : super(key: key);

  @override
  State<SingleProductScreen> createState() => _SingleProductScreenState();
}

class _SingleProductScreenState extends State<SingleProductScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SingleProductBloc>(context)
        .add(SingleProductDataLoad(id: widget.args!['id']));
  }

  int _currentSlide = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SingleProductBloc, SingleProductState>(
        builder: (context, state) {
          if (state is SingleProductLoading) {
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
          if (state is SingleProductLoadSuccess) {
            return Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  height: MediaQuery.of(context).size.height * .4,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CarouselSlider(
                            carouselController: _carouselController,
                            options: CarouselOptions(
                              height: 250,
                              aspectRatio: 16 / 9,
                              viewportFraction: 1.0,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              enlargeFactor: 0.3,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _currentSlide = index;
                                });
                              },
                            ),
                            items: state.product.detailImages.map((imageUrl) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    decoration: const BoxDecoration(
                                      color: Colors.grey,
                                    ),
                                    child: Container(
                                      width: 200,
                                      child: Image.network(
                                        '$imageBaseUrl$imageUrl',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                          Positioned(
                            bottom: 30,
                            left: MediaQuery.of(context).size.width * .4,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DotsIndicator(
                                  dotsCount: state.product.detailImages.length,
                                  position: _currentSlide,
                                  decorator: DotsDecorator(
                                    color: Color.fromARGB(58, 255, 255, 255),
                                    size: const Size(20.0, 6.0),
                                    activeSize: const Size(20.0, 6.0),
                                    activeShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    activeColor: Colors.white,
                                    spacing: const EdgeInsets.all(3.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 10,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  height: MediaQuery.of(context).size.height * .7,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          spreadRadius: 1,
                          blurRadius: 0,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 7, horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                state.product.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(
                                height: 25,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    elevation: 0,
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    "ADD TO CART",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 7, horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '\$${state.product.price}',
                                style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      "-",
                                      style: TextStyle(
                                          color: primaryColor, fontSize: 20),
                                    ),
                                    const SizedBox(
                                      width: 25,
                                    ),
                                    const Text("3"),
                                    const SizedBox(
                                      width: 25,
                                    ),
                                    Text(
                                      "+",
                                      style: TextStyle(
                                          color: primaryColor, fontSize: 20),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                          child: Text(
                            "Description",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                primaryColor,
                                const Color.fromARGB(255, 224, 220, 220),
                                const Color.fromARGB(255, 224, 220, 220)
                              ], // Replace with your desired colors
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                          height: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 7, horizontal: 10),
                          child: Text(state.product.desc),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                          child: Text(state.product.shortDesc),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          if (state is SingleProductLoadFailure) {
            print(state.reason);
            return Center(
              child: Text(state.reason!),
            );
          }

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
        },
        listener: (context, state) {},
      ),
    );
  }
}
