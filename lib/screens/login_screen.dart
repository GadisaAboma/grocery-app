import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:grocery_app/bloc/auth_bloc/auth_event.dart';
import 'package:grocery_app/bloc/auth_bloc/auth_state.dart';
import 'package:grocery_app/bloc/category_bloc.dart/category_bloc.dart';
import 'package:grocery_app/bloc/category_bloc.dart/category_event.dart';
import 'package:grocery_app/bloc/product_bloc.dart/product_bloc.dart';
import 'package:grocery_app/bloc/product_bloc.dart/product_event.dart';
import 'package:grocery_app/bloc/product_bloc.dart/product_state.dart';
import 'package:grocery_app/constants/app_routes.dart';
import 'package:grocery_app/models/auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isHide = true;
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void loginUser() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    BlocProvider.of<AuthBloc>(context).add(AuthLogin(Auth(
        phone: phoneController.text,
        password: passwordController.text,
        country: "ETH")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/placeholder.png",
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .55,
              child: Container(
                decoration: const BoxDecoration(
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
                child: Form(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Sign In",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          validator: (value) {
                            if (value == "") {
                              return "Please provide phone number";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (newValue) => phoneController.text =
                              newValue!.trim().toString(),
                          controller: phoneController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(50.0),
                              ),
                            ),
                            labelText: 'Phone',
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          validator: (value) {
                            if (value == "") {
                              return "Please provide password";
                            } else {
                              return null;
                            }
                          },
                          controller: passwordController,
                          onSaved: (newValue) => passwordController.text =
                              newValue!.trim().toString(),
                          obscureText: isHide,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(50.0),
                              ),
                            ),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isHide = !isHide;
                                  });
                                },
                                icon: isHide
                                    ? const Icon(
                                        Icons.visibility_off,
                                        color: Colors.black,
                                      )
                                    : const Icon(
                                        Icons.visibility,
                                        color: Colors.black,
                                      )),
                            labelText: 'Password',
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              elevation: 0,
                            ),
                            onPressed: () => loginUser(),
                            child: BlocConsumer<AuthBloc, AuthState>(
                                listener: (context, state) {
                              if (state is AuthOperationFailure) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(state.reason!),
                                  ),
                                );
                              }
                              if (state is AuthLoginSuccess) {
                                // BlocProvider.of<CategoryBloc>(context)
                                //     .add(CategoryDataLoad());
                                // BlocProvider.of<ProductBloc>(context)
                                //     .add(ProductDataLoad());
                                Navigator.pushNamedAndRemoveUntil(
                                    context, AppRoutes.home, (route) => false);
                              }
                            }, builder: (context, state) {
                              if (state is AuthSigningIn) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 20,
                                      width: 20,
                                      child: const CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Text(
                                      "SIGNING IN",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                );
                              }
                              return const Text("SIGN IN");
                            }),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
