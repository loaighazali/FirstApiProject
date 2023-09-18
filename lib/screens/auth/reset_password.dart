import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../api/controllers/auth_api_controller.dart';
import '../../helpers/helpers.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/code_text_field.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key, required this.email}) : super(key: key);

  final String email;

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> with Helpers {
  late TextEditingController _passwordEditingController;
  late TextEditingController _passwordConfirmationEditingController;

  late TextEditingController _firstNumberEditingController;

  late TextEditingController _secondNumberEditingController;

  late TextEditingController _thirdNumberEditingController;

  late TextEditingController _fourthNumberEditingController;

  late FocusNode _firstFocusNode;

  late FocusNode _secondFocusNode;
  late FocusNode _thirdFocusNode;

  late FocusNode _forthFocusNode;

  String? _code;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordEditingController = TextEditingController();
    _passwordConfirmationEditingController = TextEditingController();

    _firstNumberEditingController = TextEditingController();
    _secondNumberEditingController = TextEditingController();
    _thirdNumberEditingController = TextEditingController();
    _fourthNumberEditingController = TextEditingController();

    _firstFocusNode = FocusNode();
    _secondFocusNode = FocusNode();
    _thirdFocusNode = FocusNode();
    _forthFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _passwordEditingController.dispose();
    _passwordConfirmationEditingController.dispose();

    _firstNumberEditingController.dispose();
    _secondNumberEditingController.dispose();
    _thirdNumberEditingController.dispose();
    _fourthNumberEditingController.dispose();

    _firstFocusNode.dispose();
    _secondFocusNode.dispose();
    _thirdFocusNode.dispose();
    _forthFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        backgroundColor: Colors.cyan,
        title: const Text(
          'Request Password',
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
            'Enter New Password...',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
          ),
          const Text(
            'Enter New Password & received code ',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Text(
            'Email :   ${widget.email}',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                child: CodeTextField(
                  controller: _firstNumberEditingController,
                  focusNode: _firstFocusNode,
                  onChange: (value) {
                    if (value.isNotEmpty) {
                      _secondFocusNode.requestFocus();
                    }
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: CodeTextField(
                  controller: _secondNumberEditingController,
                  focusNode: _secondFocusNode,
                  onChange: (value) {
                    value.isNotEmpty
                        ? _thirdFocusNode.requestFocus()
                        : _firstFocusNode.requestFocus();
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: CodeTextField(
                  controller: _thirdNumberEditingController,
                  focusNode: _thirdFocusNode,
                  onChange: (value) {
                    value.isNotEmpty
                        ? _forthFocusNode.requestFocus()
                        : _secondFocusNode.requestFocus();
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: CodeTextField(
                  controller: _fourthNumberEditingController,
                  focusNode: _forthFocusNode,
                  onChange: (value) {
                    if (value.isEmpty) {
                      _thirdFocusNode.requestFocus();
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          AppTextField(
            hint: 'Password',
            perfixIcon: Icons.lock_outline,
            controller: _passwordEditingController,
            textInputType: TextInputType.visiblePassword,
          ),
          const SizedBox(
            height: 15,
          ),
          AppTextField(
            hint: 'Password Confirmation',
            perfixIcon: Icons.lock_outline,
            controller: _passwordConfirmationEditingController,
            textInputType: TextInputType.visiblePassword,
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(0, 50),
              backgroundColor: Colors.cyan,
            ),
            onPressed: () async => await performResetPassword(),
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

  Future<void> performResetPassword() async {
    if (checkData()) {
      await resetPassword();
    }
  }

  bool checkData() {
    if (checkCode() && checkPassword()) {

      return true;
    }
    return false;
  }

  bool checkPassword() {
    if (_passwordEditingController.text.isNotEmpty &&
        _passwordConfirmationEditingController.text.isNotEmpty) {
      if (_passwordEditingController.text ==
          _passwordConfirmationEditingController.text) {
        return true;
      }
      showSnackBar(
          context: context,
          message: 'Password & Password Confirmation is not Confirm ! ',
          error: true);
      return false;
    }
    showSnackBar(
        context: context, message: 'Enter New Password !', error: true);
    return false;
  }

  bool checkCode() {
    if (_firstNumberEditingController.text.isNotEmpty &&
        _secondNumberEditingController.text.isNotEmpty &&
        _thirdNumberEditingController.text.isNotEmpty &&
        _fourthNumberEditingController.text.isNotEmpty) {
      _code = _firstNumberEditingController.text +
          _secondNumberEditingController.text +
          _thirdNumberEditingController.text +
          _fourthNumberEditingController.text;
      return true;
    }
    showSnackBar(
        context: context, message: 'Enter Complete code !', error: true);
    return false;
  }

  Future<void> resetPassword() async {
    bool status = await AuthApiController().resetPassword(
      context,
      email: widget.email,
      code: _code!,
      password: _passwordConfirmationEditingController.text,
    );
    if(status)Navigator.pop(context);
  }
}
