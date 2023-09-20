import 'package:elancer_api/helpers/helpers.dart';
import 'package:elancer_api/screens/auth/reset_password.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../api/controllers/auth_api_controller.dart';
import '../../widgets/app_text_field.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> with Helpers {
  late TextEditingController _emailEditingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailEditingController = TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _emailEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white, size: 30),
        backgroundColor: Colors.cyan,
        title: const Text(
          'Forget Password',
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
            'Enter Email...',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
          ),
          const Text(
            'Reset code will be sent !',
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
            height: 50,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(0, 50),
              backgroundColor: Colors.cyan,
            ),
            onPressed: () async => await performForgetPassword(),
            child: const Text(
              'SEND',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> performForgetPassword() async {
    if (checkData()) {
      await forgetPassword();
    }
  }

  bool checkData() {
    if (_emailEditingController.text.isNotEmpty) {
      return true;
    } else {
      showSnackBar(
          context: context, message: 'Enter required data !', error: true);
      return false;
    }
  }

  Future<void> forgetPassword() async {
    bool status = await AuthApiController().forgetPassword(
      context,
      email: _emailEditingController.text,
    );
     if(status)
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResetPassword(email: _emailEditingController.text),
          ));
  }
}
