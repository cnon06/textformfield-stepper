// ignore_for_file: prefer_final_fields, unused_field

import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_11/secondPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Advanced Stepper Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _userName = "", _eMail = "", _password = "";
  int currentStep = 0;
  final key0 = GlobalKey<FormFieldState>();
  final key1 = GlobalKey<FormFieldState>();
  final key2 = GlobalKey<FormFieldState>();
  bool onChangedController = false;

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Stepper(
                  type: StepperType.vertical,
                  currentStep: currentStep,
                  // onStepTapped: (int step) {
                  //   currentStep = step;
                  // },
                  onStepCancel: () {
                    setState(() {
                      if (currentStep > 0) {
                        currentStep--;
                        onChangedController = false;
                      }
                    });
                  },
                  onStepContinue: () {
                    setState(() {
                      if (selectKey().currentState!.validate()) {
                        // print("step: $currentStep");
                        selectKey().currentState!.save();
                        onChangedController = false;
                        // selectKey().currentState!.save();
                        if (currentStep < mySteps().length - 1) currentStep++;
                      }
                    });
                  },
                  steps: mySteps()),
            )
          ],
        ),
      ),
    );
  }

  GlobalKey<FormFieldState> selectKey() {
    Map<int, dynamic> globalKeys = {0: key0, 1: key1, 2: key2};

    if (globalKeys[currentStep] != null) {
      return globalKeys[currentStep];
    } else {
      return key0;
    }
  }

  bool setActivePasive({required stepNo}) {
    return stepNo == currentStep ? true : false;
  }

  List<Step> mySteps() {
    List<Step> steps = [
      Step(
        state: myStepState(0),
        title: const Text("Username"),
        subtitle: const Text("Username Subtitle"),
        isActive: setActivePasive(stepNo: 0),
        content: TextFormField(
          key: key0,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
            label: Text("Username TextFormfield"),
            hintText: "Username Hinttext",
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            onChangedController = true;
            myStepState(0);
            setState(() {});
          },
          validator: (value) {
            if (value!.length < 6) return "less than 6 characters entered";
          },
          onSaved: (value) {
            _userName = value.toString();
          },
        ),
      ),
      Step(
        state: myStepState(1),
        title: const Text("Email"),
        subtitle: const Text("Email Subtitle"),
        isActive: setActivePasive(stepNo: 1),
        content: TextFormField(
          keyboardType: TextInputType.emailAddress,
          key: key1,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
            label: Text("Email TextFormfield"),
            hintText: "Email Hinttext",
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            onChangedController = true;
            myStepState(1);
            setState(() {});
          },
          validator: (value) {
            if (!EmailValidator.validate(value!) && onChangedController) {
              return "this is not email";
            }

            // return !value!.contains("@") ? "this is not email" : null;
          },
          onSaved: (value) {
            _eMail = value.toString();
          },
        ),
      ),
      Step(
        state: myStepState(2),
        title: const Text("Password"),
        subtitle: const Text("Password: 1234"),
        isActive: setActivePasive(stepNo: 2),
        content: TextFormField(
          obscureText: true,
          keyboardType: TextInputType.emailAddress,
          key: key2,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
            label: Text("Password TextFormfield"),
            hintText: "Password Hinttext",
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            onChangedController = true;
            myStepState(2);
            setState(() {});
          },
          validator: (value) {
            if (value != "1234" && onChangedController) {
              return "password is not correct";
            }
          },
          onSaved: (value) {
            _password = value.toString();
            print(
                "User Name: $_userName, E-Mail: $_eMail, Password: $_password");
            _password = value.toString();
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => SecondPage(
                          userName: _userName,
                          eMail: _eMail,
                          password: _password,
                        )));
          },
        ),
      ),
    ];
    return steps;
  }

  StepState myStepState(int index) {
    StepState sState = StepState.editing;
    setState(() {
      if (index < currentStep) {
        sState = StepState.complete;
      } else if (index > currentStep) {
        sState = StepState.indexed;
      } else if (selectKey().currentState?.validate() != null &&
          index == currentStep) {
        if (selectKey().currentState!.validate()) {
          sState = StepState.editing;
        } else {
          sState = StepState.error;
        }
      }

      // sState =  ?  StepState.complete : StepState.error;
    });
    //Map<int, StepState> states = {0: StepState.complete, 1 Sta};
    return sState;
  }
}
