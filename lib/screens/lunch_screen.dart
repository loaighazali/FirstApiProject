import 'package:elancer_api/pref/shared_pref_controller.dart';
import 'package:flutter/material.dart';

class LunchScreen extends StatefulWidget {
  const LunchScreen({Key? key}) : super(key: key);

  @override
  State<LunchScreen> createState() => _LunchScreenState();
}

class _LunchScreenState extends State<LunchScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String rout = SharedPrefController().loggedIn ? '/users_screen' : '/login_screen';
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, rout);
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
            colors: [
             Colors.lightBlue.shade200,
             Colors.lightBlue.shade900,
            ]
          ),
        ),
        child:const Text(
            'Api App',
          style: TextStyle(
            fontSize: 35,
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
