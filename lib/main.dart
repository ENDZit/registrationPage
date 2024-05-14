import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Registration page",
            style: TextStyle(color: Colors.white70),
          ),
          backgroundColor: Colors.black,
        ),
        body: const SingleChildScrollView(child: InformationPage()),
        backgroundColor: Colors.white,
      ),
    );
  }
}

enum Gender {
  male("Male"),
  female("Female");

  final String text;

  const Gender(this.text);
}

class InformationPage extends StatefulWidget {
  const InformationPage({super.key});

  @override
  InformationPageState createState() => InformationPageState();
}

class InformationPageState extends State<InformationPage> {
  String dropdownValue = 'Student';
  String globalPassword = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Form fields go here
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Your name',
              hintText: 'Enter your name',
            ),
            validator: (name) {
              if (name == "") {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Your email',
              hintText: 'Enter your email',
            ),
            validator: (email) {
              if (email == null || email == "") {
                return 'Please enter your email';
              } else if (!email.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Your age',
              hintText: 'Enter your age',
            ),
            validator: (age) {
              if (age == "") {
                return 'Please enter your age';
              }
              return null;
            },
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(2)
            ],
          ),
          TextFormField(
            decoration: const InputDecoration(
                labelText: 'Password', hintText: 'Enter your password'),
            obscureText: true,
            validator: (password1) {
              globalPassword = password1.toString();
              if (password1 == "") {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
                labelText: 'Confirm password', hintText: 'Enter yor password'),
            obscureText: true,
            validator: (password2) {
              if (password2 == "") {
                return 'Please enter your password';
              } else if (password2 != globalPassword) {
                return 'Password isnt match';
              }
              return null;
            },
          ),
          GenderSelectionWidget(),
          DropdownButton<String>(
            value: dropdownValue,
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
            items: <String>['Student', 'Worker', 'Pensioner']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          MaterialButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Perform submission logic
              }
            },
            color: Colors.black26,
            child: Container(
              constraints:
              const BoxConstraints(minWidth: 88.0, minHeight: 36.0),
              alignment: Alignment.center,
              child: const Text(
                'Submit',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GenderSelectionWidget extends StatefulWidget {
  const GenderSelectionWidget({super.key});

  @override
  _GenderSelectionWidgetState createState() => _GenderSelectionWidgetState();
}

class _GenderSelectionWidgetState extends State<GenderSelectionWidget> {
  Gender? _selectedOption = Gender.male;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: Gender.values
          .map((option) => RadioListTile<Gender>(
        title: Text(option.text),
        value: option,
        groupValue: _selectedOption,
        onChanged: (value) {
          setState(() {
            _selectedOption = value!;
          });
        },
      ))
          .toList(),
    );
  }
}
