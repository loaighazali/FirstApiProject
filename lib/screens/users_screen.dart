import 'package:elancer_api/api/controllers/users_api_controller.dart';
import 'package:elancer_api/models/user.dart';
import 'package:flutter/material.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {

  List<User> _users = <User>[];
  late Future<List<User>> _future ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = UserApiController().getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title:const Text('Users'),
        centerTitle: true,
      ),

      body: FutureBuilder<List<User>>(
        future: _future,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
          else if(snapshot.hasData && snapshot.data!.isNotEmpty){
            _users = snapshot.data ?? [];
            return ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading:CircleAvatar(radius: 30, backgroundImage: NetworkImage(_users[index].image)),
                  title: Text("${_users[index].firstName}" "${_users[index].lastName}"),
                  subtitle: Text(_users[index].email),
                );
              },);
          }else{
            return const Center(child: Text('NO DATA'),);
          }
        },
      ),
    );
  }
}
