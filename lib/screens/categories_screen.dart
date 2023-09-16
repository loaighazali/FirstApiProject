import 'package:elancer_api/api/controllers/users_api_controller.dart';
import 'package:flutter/material.dart';

import '../models/categories.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late Future<List<Categories>> _future;

  List<Categories> _categories = <Categories>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = UserApiController().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Categories'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            _categories = snapshot.data ?? [];
            return GridView.builder(
              padding: EdgeInsetsDirectional.all(20),
              itemCount: _categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 10 , mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                return Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side:const BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(_categories[index].image),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(_categories[index].title),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Column(
                children: [
                  Icon(Icons.warning_amber, size: 30),
                  Text(
                    'NO DATA',
                    style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
