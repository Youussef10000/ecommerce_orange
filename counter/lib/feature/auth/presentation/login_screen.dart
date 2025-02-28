import 'package:counter/feature/auth/logic/auth_cubit.dart';
import 'package:counter/feature/auth/presentation/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_input.dart';
import '../../Bottom_navigation/Bottom_navigation_Bar.dart';
import '../../home/presentation/home_screen.dart';
import 'ResetPassword.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _showForgetPasswordBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),),
      builder: (context) {
        return ResetPasswordBottomSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthLoginLoading) {
              showDialog(
                context: context,
                builder: (context) => const Center(child: CircularProgressIndicator()),
              );
            }

            if (state is AuthLoginSuccess) {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                  Bottom_Navigation_Bar(title1:"Home",title2: "Browse",title3: "Wishlist",title4: "Cart",title5: "profile",)));
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Success Login"),
              ));
            }

            if (state is AuthLoginFailure) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
              ));
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    const Text(
                      "Login to your \naccount.",
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 24),
                    CustomTextInput(
                      hintText: 'Enter Your Username',
                      labelText: 'Username',
                      controller: userNameController,
                    ),
                    const SizedBox(height: 24),
                    CustomTextInput(
                      hintText: 'Enter Your Password',
                      labelText: 'Password',
                      controller: passwordController,
                      isPassword: true,
                    ),
                    const SizedBox(height: 10),

                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () => _showForgetPasswordBottomSheet(context),
                        child: Text(
                          "Forget Password?",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                    CustomButton(
                      label: 'Login',
                      onPressed: () {
                        context.read<AuthCubit>().login(
                          userNameController.text, passwordController.text,
                        );
                      },
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: const [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text("or continue with"),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade200,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: CustomButton(
                        label: 'Continue with Google',
                        iconWidget: SvgPicture.asset(
                          'assets/svgs/gogle.svg',
                          height: 24,
                        ),
                        color: Colors.white,
                        textColor: Colors.black,
                        onPressed: () {
                          // Google login logic here
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade200,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: CustomButton(
                        label: 'Continue with Facebook',
                        iconWidget: Icon(
                          Icons.facebook,
                          color: Colors.blue,
                        ),
                        color: Colors.white,
                        textColor: Colors.black,
                        onPressed: () {
                          // Facebook login logic here
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Register",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
