import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/service/service_locator.dart';
import 'package:instagram_clone/core/util/utility.dart';
import 'package:instagram_clone/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:instagram_clone/features/post/presentation/pages/home_page.dart';
import 'signup_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);
  static const String id = "signin_page";

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthBloc bloc = locator<AuthBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox.shrink(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // #app_name
                          const Text(
                            "Instagram",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 45,
                                fontFamily: "Billabong"),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          // #email
                          textField(hintText: "Email", controller: emailController),
                          const SizedBox(
                            height: 10,
                          ),

                          // #password
                          textField(
                              hintText: "Password", controller: passwordController),
                          const SizedBox(
                            height: 20,
                          ),
                          RichText(
                            text: TextSpan(
                                text: "Forgot your login details? ",
                                style: const TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(
                                    text: " Get help logging in.",
                                    style: const TextStyle(
                                        color: Color.fromRGBO(4,
                                            65, 142, 1.0),
                                        fontWeight: FontWeight.bold),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushReplacementNamed(
                                            context, SignUpPage.id);
                                      },
                                  )
                                ]),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // #signin
                          button(title: "Sign In", onPressed: () {
                            bloc.add(SignInUserEvent(email: emailController.text, password: passwordController.text));
                          }),
                        ],
                      ),
                      RichText(
                        text: TextSpan(
                            text: "Don't have an account? ",
                            style: const TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                text: "Sign Up",
                                style: const TextStyle(fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacementNamed(
                                        context, SignUpPage.id);
                                  },
                              )
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if(state is SignInSuccessState) {
                  Utils.fireSnackBar("Successfully Sign In", context);
                  Navigator.pushReplacementNamed(context, HomePage.id);
                }
              },
              builder: (context, state) {
                if(state is AuthLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  ClipRRect textField(
      {required String hintText,
      bool? isHidden,
      required TextEditingController controller}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(7.5),
      child: TextField(
        style: const TextStyle(fontSize: 16, color: Colors.black),
        controller: controller,
        obscureText: isHidden ?? false,
        decoration: InputDecoration(
          focusedBorder:const OutlineInputBorder(),
            border: const OutlineInputBorder(),
            filled: true,
            fillColor: Colors.white54.withOpacity(0.2),
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey)),
      ),
    );
  }

  ElevatedButton button(
      {required String title, required void Function() onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        minimumSize:const Size(double.infinity, 50),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.5),
          side: BorderSide(color: Colors.white54.withOpacity(0.2), width: 2),
        ),
      ),
      onPressed: onPressed,
   child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }
}
