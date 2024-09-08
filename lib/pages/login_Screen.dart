import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_d0_app/FireStore.dart';
import 'package:to_d0_app/app_color.dart';
import 'package:to_d0_app/home.dart';
import 'package:to_d0_app/models/customTextField.dart';
import 'package:to_d0_app/pages/register_Screen.dart';
import 'package:to_d0_app/providers/listProviders.dart';

import '../providers/USer_Provider.dart';

class loginScreen extends StatelessWidget {
  TextEditingController userNameController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  static const String routName = "login_screen";
  @override
  Widget build(BuildContext context) {
    var Userprovider = Provider.of<UserProvider>(context, listen: false);
    var listprovider = Provider.of<ListProvidder>(context);

    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Welcome Back !',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: AppColor.blackcolor),
              ),
              SizedBox(
                height: 50,
              ),
              CustomTextField(
                  labelText: "Email",
                  validator: (text) {
                    final bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(EmailController.text);
                    if (!emailValid) {
                      return "Please Enter a valid Email";
                    }
                    return null;
                  },
                  textController: EmailController,
                  keyboardType: TextInputType.emailAddress,
                  scure: false),
              SizedBox(height: 16),
              CustomTextField(
                  labelText: "Password",
                  validator: (text) {
                    if (text!.length < 6) {
                      return "please Valid Password ar least 6 char";
                    }
                    return null;
                  },
                  textController: PasswordController,
                  keyboardType: TextInputType.number,
                  scure: true),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Loding ..')),
                    );
                    try {
                      final credential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                        email: EmailController.text,
                        password: PasswordController.text,
                      );

                      var useer = await Firestore.ReadUserFireStore(
                          credential.user!.uid);
                      if (useer == null) {
                        return;
                      }
                      Userprovider.ChangeUser(useer);
                      listprovider.getAllTasksFromFireStore(
                          Userprovider.currentUser!.id);
                      Navigator.pushReplacementNamed(context, Home.routName);
                      print(credential.user!.uid);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('The password provided is too weak.')),
                        );
                        print('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'The account already exists for that email.')),
                        );
                        print('The account already exists for that email.');
                      }
                    } catch (e) {

                      print(e);
                    }
                  }
                  // Implement registration logic here
                },
                child: Text(
                  'Login',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primarycolor,
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, RegisterScreen.routName);
                  },
                  child: Text(
                    "SignIn",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
