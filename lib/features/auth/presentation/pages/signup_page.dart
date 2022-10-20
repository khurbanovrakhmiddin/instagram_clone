import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/service/service_locator.dart';
import 'package:instagram_clone/core/util/auth_button.dart';
import 'package:instagram_clone/core/util/text_filed_view.dart';
import 'package:instagram_clone/core/util/utility.dart';
import 'package:instagram_clone/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:instagram_clone/features/auth/presentation/pages/signin_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  static const String id = "signup_page";

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  AuthBloc bloc = locator<AuthBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                          // #fullname
                          AuthTextField(
                              hintText: "FullName",
                              controller: fullNameController),
                          const SizedBox(
                            height: 10,
                          ),

                          // #email
                          AuthTextField(
                              hintText: "Email", controller: emailController),
                          const SizedBox(
                            height: 10,
                          ),

                          // #password
                          AuthTextField(
                              hintText: "Password",
                              controller: passwordController),
                          const SizedBox(
                            height: 10,
                          ),

                          // #password
                          AuthTextField(
                              hintText: "Confirm Password",
                              controller: confirmPasswordController),
                          const SizedBox(
                            height: 10,
                          ),

                          // #signin
                          AuthButton(title: "Sign Up", onPressed: () {
                            bloc.add(SignUpUserEvent(fullName: fullNameController.text, email: emailController.text, password: passwordController.text, confirmPassword: confirmPasswordController.text));
                          }),
                        ],
                      ),
                      RichText(
                        text: TextSpan(
                            text: "Already have an account? ",
                            style: const TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                text: "Sign In",
                                style:
                                    const TextStyle(fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacementNamed(
                                        context, SignInPage.id);
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
                if(state is SignUpSuccessState) {
                  Utils.fireSnackBar("Successfully Sign Up", context);
                  Navigator.pushNamed(context, SignInPage.id);
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


}

