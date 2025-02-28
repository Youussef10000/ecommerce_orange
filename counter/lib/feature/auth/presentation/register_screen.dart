import 'package:counter/feature/auth/logic/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_input.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthRegisterLoading) {
              showDialog(
                  context: context,
                  builder: (context) =>
                      Center(child: CircularProgressIndicator()));
            }

            if (state is AuthRegisterSuccess) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Success Registeration"),
              ));
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LoginScreen();
              }));
            }

            if (state is AuthRegisterFailure) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
              ));
            }
          },
          builder: (context, state) {
            return SafeArea(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),
                  Text(
                    "Register new  \naccount.",
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  CustomTextInput(
                    hintText: 'Enter Your Username',
                    labelText: 'Username',
                    controller: userNameController,
                  ),
                  SizedBox(height: 24.h),
                  CustomTextInput(
                    hintText: 'Enter Your Password',
                    labelText: 'Password',
                    controller: passwordController,
                    isPassword: true,
                  ),
                  SizedBox(height: 24.h),

                  CustomTextInput(
                    hintText: 'Confirm password',
                    labelText: 'Password',
                    controller: passwordController,
                    isPassword: true,
                  ),
                  SizedBox(height: 24.h),


                  CustomTextInput(
                    hintText: 'Enter Your email',
                    labelText: 'email',
                    controller: emailController,
                  ),
                  SizedBox(height: 24.h),
                  CustomTextInput(
                    hintText: 'Enter Your phone',
                    labelText: 'phone',
                    controller: phoneController,
                  ),
                  SizedBox(height: 24.h),
                  CustomButton(
                      label: 'Register',
                      onPressed: () {
                        context.read<AuthCubit>().register(
                            userNameController.text,
                            passwordController.text,
                            emailController.text,
                            phoneController.text);
                      }),

                   SizedBox(height: 30),
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
                  const SizedBox(height: 15),
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
                ],
              ),
            ));
          },
        ),
      ),
    );
  }
}
