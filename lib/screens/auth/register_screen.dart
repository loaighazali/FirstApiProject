import 'package:elancer_api/api/controllers/auth_api_controller.dart';
import 'package:elancer_api/helpers/helpers.dart';
import 'package:elancer_api/models/students.dart';
import 'package:flutter/material.dart';

import '../../widgets/app_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with Helpers {

  late TextEditingController _nameEditingController ;
  late TextEditingController _emailEditingController ;
  late TextEditingController _passwordEditingController ;

  String groupValue  = 'M';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameEditingController = TextEditingController();
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        iconTheme: const IconThemeData(size: 30 , color: Colors.white),
        title: const Text(
          'Register',
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
            height: 60,
          ),
          const Text(
            'Create New Account...',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
          ),
          const Text(
            'Enter details below',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          AppTextField(
            hint: 'Full Name',
            perfixIcon: Icons.person_outline_outlined,
            controller: _nameEditingController,
            textInputType: TextInputType.name,
          ),
          const SizedBox(
            height: 30,
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
            height: 20,
          ),

          Row(
            children: [
              Expanded(
                child: RadioListTile(
                  activeColor: Colors.cyan,
                  value: 'M',
                  groupValue: groupValue,
                  onChanged: (value) {
                    if(value != null){
                      setState(() {
                        groupValue = 'M';
                      });
                    }
                  },
                  title: const Text(
                    'Male',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),

              Expanded(
                child: RadioListTile(
                  activeColor: Colors.cyan,
                  value: 'F',
                  groupValue: groupValue,
                  onChanged: (value) {
                    if(value != null){
                      setState(() {
                        groupValue = 'F';
                      });
                    }
                  },
                  title: const Text(
                    'Female',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 50,
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(0, 50),
              backgroundColor: Colors.cyan,
            ),
            onPressed: () async => await performRegister(),
            child: const Text(
              'Register',
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

  Future<void> performRegister()async{
    if(checkData()){
      await register();
    }
  }

   bool checkData(){
    if(_nameEditingController.text.isNotEmpty &&
    _passwordEditingController.text.isNotEmpty &&
    _passwordEditingController.text.isNotEmpty){
      return true;
    }
    else{
      showSnackBar(context: context, message: 'Enter required data !' , error: true);
      return false;
    }
    }

  Future<void> register()async{
   bool status = await AuthApiController().register(context, students: students);
   if(status) Navigator.pop(context);
  }

  Students get students{
    Students students = Students();
    students.fullName = _nameEditingController.text;
    students.email = _emailEditingController.text;
    students.password = _passwordEditingController.text;
    students.gender = groupValue;
    return students;
  }
}


