// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:omnisell_crm/core/constants/colors.dart';
import 'package:omnisell_crm/core/constants/textstyles.dart';
import 'package:omnisell_crm/presentation/login_screen/controlller/login_controller.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: const Color(0xfffaab54),
      appBar: AppBar(
        actions: [
          Text(
            "SIGN IN",
            style: GLTextStyles.cabinStyle(
                color: Colors.white, size: 22, weight: FontWeight.w800),
          ),
          SizedBox(width: size.width * .05),
        ],
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        backgroundColor: const Color(0xfffaab54),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(height: size.height * .09),
            Container(
              height: size.height * .8,
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.2),
                    blurRadius: 10,
                    offset: Offset(5, 0),
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 25, top: 35, right: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome Back",
                      style: GLTextStyles.rubikStyle(
                          weight: FontWeight.w800,
                          color: ColorTheme.yellow,
                          size: 24),
                    ),
                    Text(
                      "Continue to Sign in!",
                      style: GLTextStyles.openSans(
                          weight: FontWeight.w500,
                          color: ColorTheme.blue,
                          size: 22),
                    ),
                    SizedBox(height: size.width * .075),
                    Text(
                      "EMAIL",
                      style: GLTextStyles.openSans(
                          size: 14, weight: FontWeight.w500),
                    ),
                    SizedBox(height: size.width * .01),
                    TextFormField(
                      controller: emailController,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 12.0),
                      ),
                      style: TextStyle(
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: size.width * .03),
                    Text(
                      "PASSWORD",
                      style: GLTextStyles.openSans(
                          size: 14, weight: FontWeight.w500),
                    ),
                    SizedBox(height: size.width * .01),
                    Consumer<LoginController>(builder: (context, controller, _) {
                      return TextFormField(
                        controller: passwordController,
                        obscureText: controller.visibility,
                        obscuringCharacter: '*',
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 12.0),
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.onPressed();
                            },
                            icon: Icon(
                              controller.visibility == true
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              size: 18,
                              color: controller.visibility == true
                                  ? Colors.grey
                                  : Colors.black,
                            ),
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      );
                    }),
                    SizedBox(height: size.width * .06),
                    SizedBox(
                      height: size.height * 0.085,
                      width: size.width * 0.95,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.circular(10)),
                        color: ColorTheme.blue,
                        onPressed: () {
                          Provider.of<LoginController>(context, listen: false)
                              .onLogin(emailController.text.trim(),
                                  passwordController.text.trim(), context);
                        },
                        child: Text(
                          "Sign in",
                          style: GLTextStyles.openSans(
                              color: ColorTheme.white,
                              size: 20,
                              weight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
