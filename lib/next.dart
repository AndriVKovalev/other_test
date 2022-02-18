import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:other_test/login.dart';
import 'package:other_test/user_list.dart';
//import 'package:flutter/foundation.dart';
String URL_LIST = "https://jsonplaceholder.typicode.com/todos?userId="  ;




Future<List<Posts>> fetchPosts() async {
  final response = await http
      .get(Uri.parse(URL_LIST));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    //return Posts.fromJson(jsonDecode(response.body));
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((ts) => Posts.fromJson(ts)).toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Posts');
  }
}





class NextScreen extends StatefulWidget {
  final int title;
  final String myout;
  final String nameout;
  const NextScreen({Key? key, this.title=0, this.myout='', this.nameout='' }): super(key: key);




  @override
  _NextScreenState createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  late Future<List<Posts>> futurePosts;
  late List<Posts> usersListData;


  @override
  void initState() {
    super.initState();
    URL_LIST = "https://jsonplaceholder.typicode.com/todos?userId="  ;
    URL_LIST=URL_LIST+widget.title.toString();
    futurePosts = fetchPosts();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Tasks for: " +widget.nameout, style: const TextStyle(fontSize: 16,),),
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
              leading: const Icon(Icons.arrow_back),
              title: const Text("Back to list"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondScreen()
                  ),
                );
              },
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
              leading: const Icon(Icons.info),
              title: const Text("About"),
              onTap: () {
                showAboutDialog(context: context,
                applicationName: "Курсовой проект");
              },
            ),
          ],
        ),
      ),

      body:Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(widget.myout, style: const TextStyle(fontSize: 14), textAlign: TextAlign.center ,),
          ),
          Expanded(
            child: FutureBuilder<List<Posts>>(
              future: futurePosts,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  usersListData = snapshot.data!;
                  return _usersListView(usersListData);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),

    );
  }
}

ListView _usersListView(data) {
  return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return CheckboxListTile(
          title: Text(data[index].id.toString()+". "+ data[index].title,
            style: const TextStyle(fontSize: 12)  ,),
            value: data[index].completed, onChanged: (val){ },
        );
      });
}




class Posts {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  const Posts({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  factory Posts.fromJson(Map<String, dynamic> json) {
    return Posts(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      completed: json['completed'],
    );
  }
}


