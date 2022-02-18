import 'dart:async';
import 'dart:convert';

import 'package:other_test/login.dart';
import 'package:other_test/next.dart';
import 'package:other_test/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


const String URL = "https://jsonplaceholder.typicode.com/users";


class SecondScreen extends StatelessWidget {
   const SecondScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of users'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                  color: Colors.blue
              ),
              child: Container(
                height: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(

                      child: const Icon(Icons.airline_seat_flat),
                    ),
                    const Text("Меню"),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text("Logout"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyApps()
                    ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.info ),
              title: const Text("About"),
              onTap: () {
                showAboutDialog(context: context,
                applicationName: "Курсовой проект");

              },
            ),
          ],
        ),
      ),
      body: const Center(
        child:UsersListScreen(),
      ),
    );
  }
}



Future<List<User>> _fetchUsersList() async {
  final response = await http.get(Uri.parse(URL));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((user) => User.fromJson(user)).toList();
  } else {
    throw Exception('Failed to load users from API');
  }
}

ListView _usersListView(data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return ListTile(
            title: Text(data[index].id.toString() + " "+ data[index].name ,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                )),
            subtitle: Text(data[index].email),
            onTap: (){
              Map<String,dynamic> aDdd = data[index].address;
              Map<String,dynamic> cOom = data[index].company;
              var addd =aDdd.values.toString();
              var coom = cOom.values.toString();
              String outName =  data[index].name ;
              String outData = 'Username: '+ data[index].username + ', Email: '+ data[index].email + ' \n'
                  + addd + ', \n'
                  'Company:\n' + coom ;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NextScreen(title: data[index].id, myout: outData, nameout: outName)),
              );
//                Navigator.of(context).pushNamed('/next');
            },
          );
      });
}

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({Key? key}) : super(key: key);

  @override
  _UsersListScreenState createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  late Future<List<User>> futureUsersList;
  late List<User> usersListData;
  String outData="";

  @override
  void initState() {
    super.initState();
    futureUsersList = _fetchUsersList();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder<List<User>>(
            future: futureUsersList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                usersListData = snapshot.data!;
                return _usersListView(usersListData);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return const CircularProgressIndicator();
            })
    );
  }
}
