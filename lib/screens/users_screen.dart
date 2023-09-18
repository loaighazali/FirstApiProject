import 'package:elancer_api/api/controllers/auth_api_controller.dart';
import 'package:elancer_api/api/controllers/users_api_controller.dart';
import 'package:elancer_api/helpers/helpers.dart';
import 'package:elancer_api/models/user.dart';
import 'package:flutter/material.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> with Helpers {
  List<User> _users = <User>[];
  late Future<List<User>> _future;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = UserApiController().getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        title: const Text(
          'Users',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/image_screen');
            },
            icon: Icon(Icons.image),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/categories_screen');
            },
            icon: const Icon(Icons.category),
          ),
          IconButton(
            onPressed: () async {
              bool logout = await AuthApiController().logOut();
              if (logout) {
                Navigator.pushReplacementNamed(context, '/login_screen');
                showSnackBar(
                    context: context, message: 'Succssefully Logout :(');
              }
            },
            icon: const Icon(Icons.login_outlined),
          ),
        ],
      ),
      body: FutureBuilder<List<User>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            _users = snapshot.data ?? [];
            return ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(_users[index].image)),
                  title: Text(
                      "${_users[index].firstName}" "${_users[index].lastName}"),
                  subtitle: Text(_users[index].email),
                );
              },
            );
          } else {
            return const Center(
              child: Text('NO DATA'),
            );
          }
        },
      ),
    );
  }
}
