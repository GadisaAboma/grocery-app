import 'package:flutter/material.dart';
import 'package:grocery_app/constants/app_routes.dart';
import 'package:grocery_app/constants/constants.dart';

class FavoritesWidget extends StatelessWidget {
  const FavoritesWidget({super.key});

  Widget favoriteItemBuilder(context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      // width: MediaQuery.of(context).size.width,
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: SizedBox(
              height: 120,
              child: Image.asset("assets/placeholder.png"),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width * .557,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: const [
                          Expanded(
                            child: Text(
                              "Banana",
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ),
                          Icon(
                            Icons.favorite,
                            color: Color(0xFFFF2E6C),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$28.89",
                        style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 19),
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: const Color.fromARGB(255, 231, 227, 227),
                          ),
                          child: const Text(
                            "Add to cart",
                            style: TextStyle(fontSize: 13),
                          ))
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      color: Colors.white,
      child: ListView(
        children: [
          Container(
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Text(
                "Item details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
              ),
            ),
          ),
          const Divider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              favoriteItemBuilder(context),
              const SizedBox(
                height: 20,
              ),
              favoriteItemBuilder(context),
              SizedBox(
                height: 20,
              ),
              favoriteItemBuilder(context),
              SizedBox(
                height: 20,
              ),
              favoriteItemBuilder(context),
            ],
          )
        ],
      ),
    );
  }
}
