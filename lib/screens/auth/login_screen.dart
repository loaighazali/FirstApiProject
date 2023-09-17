import 'package:elancer_api/widgets/app_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailEditingController;
  late TextEditingController _passwordEditingController;
  late TapGestureRecognizer _gestureRecognizer ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
    _gestureRecognizer = TapGestureRecognizer();
    _gestureRecognizer.onTap = navigatorRegisterScreen;
  }
  
  void navigatorRegisterScreen(){
    Navigator.pushNamed(context, '/register_screen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text(
          'Login',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsetsDirectional.all(20),
        children: [
         const SizedBox(
            height: 80,
          ),
          const Text(
            'Welcome Back...',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
          ),
          const Text(
            'Enter your Email & Password',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 70,
          ),
          AppTextField(
            hint: 'Email',
            perfixIcon: Icons.email_outlined,
            controller: _emailEditingController,
            textInputType: TextInputType.emailAddress,
          ),
          const SizedBox(
            height: 30,
          ),
          AppTextField(
            hint: 'Password',
            perfixIcon: Icons.lock_outline,
            controller: _passwordEditingController,
            textInputType: TextInputType.visiblePassword,
            obscur: true,
          ),
          const SizedBox(
            height: 70,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(0, 50),
              backgroundColor: Colors.cyan,
            ),
            onPressed: () {},
            child: const Text(
              'Login',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          ),

          const SizedBox(height: 20,),

          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: 'Don\'t have an account ?   ',
              style:const TextStyle(
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  recognizer: _gestureRecognizer,
                  text: 'Create Now! ',
                  style: const TextStyle(
                    color: Colors.cyan,
                  )
                ),
              ]
            ),
          ),
        ],
      ),
    );
  }
}
