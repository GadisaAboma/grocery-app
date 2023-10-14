import 'package:flutter/material.dart';
import 'package:grocery_app/constants/app_routes.dart';
import 'package:grocery_app/constants/constants.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  Widget cartItemBuilder(String imagePath, String name, String desc,
      String price, String count, context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      // width: MediaQuery.of(context).size.width,
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: SizedBox(
              height: 100,
              child: Image.asset(imagePath),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width * .6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Text(
                      desc,
                    ),
                  ],
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        price,
                        style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 19),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: const Color.fromARGB(255, 231, 227, 227),
                        ),
                        child: Row(
                          children: [
                            const Text(
                              "-",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 20),
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            Text(count),
                            const SizedBox(
                              width: 25,
                            ),
                            const Text(
                              "+",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 20),
                            ),
                          ],
                        ),
                      )
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
              cartItemBuilder("assets/placeholder.png", "FRIUTS", "Banana",
                  "\$28.8", "3", context),
              const SizedBox(
                height: 20,
              ),
              cartItemBuilder("assets/placeholder.png", "VEGETABLES",
                  "Broccoli", "\$6.3", "1", context),
              SizedBox(
                height: 20,
              ),
              cartItemBuilder("assets/placeholder.png", "MUSHROOM",
                  "Oyster Mushroom", "\$2.7", "1", context),
              const SizedBox(
                height: 110,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Total \$6",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () =>
                      Navigator.of(context).pushNamed(AppRoutes.thankYou),
                  child: const Text("PLACE ORDER"),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
