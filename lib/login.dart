import 'package:flutter/material.dart';
import 'package:other_test/user_list.dart';

class MyApps extends StatelessWidget {
  const MyApps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //const appTitle = 'Авторизация';

    return  const Scaffold(
      //appBar: AppBar(
      // title: const Text(appTitle),
      //),
      body: Center(child: MyCustomForm()),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    const borderStyleField = OutlineInputBorder(
        borderRadius:  BorderRadius.all(Radius.circular( 36)),
        borderSide: BorderSide(
            color: Color(0xFFECEFF1), width: 1
        )
    );

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          const Text("Phone"),
          const SizedBox(height: 5,),
          SizedBox( width: 250,
            child: TextFormField(
              keyboardType: TextInputType.phone,
              decoration:  const InputDecoration(
                  contentPadding: EdgeInsets.all(8.0),
                  filled: true,
                  fillColor: Color(0xFFECEFF1),
                  enabledBorder: borderStyleField ,
                  focusedBorder: borderStyleField ,
                  hintText: "+7"
              ),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value != '+7-123-456-7890') {
                  return 'Please enter +7-123-456-7890';
                }
                return null;
              },
            ),
          ),
          const SizedBox( height: 25,),
          SizedBox( width: 250,
            child: TextFormField(
              // The validator receives the text that the user has entered.
              decoration:  const InputDecoration(
                contentPadding: EdgeInsets.all(8.0),
                filled: true,
                fillColor: Color(0xFFECEFF1),
                enabledBorder: borderStyleField ,
                focusedBorder: borderStyleField ,
              ),

              validator: (value) {
                if (value != "parol" ) {
                  return 'Please write  parol';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  //Navigator.pushNamed(context, '/second');

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SecondScreen()),
                  );

                }
              },
              child: const Text('Login'),
            ),
          ),
          const Text('Please enter +7-123-456-7890 and parol'),
        ],
      ),
    );
  }
}

