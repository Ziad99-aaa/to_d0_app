import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_d0_app/FireStore.dart';
import 'package:to_d0_app/User.dart';
import 'package:to_d0_app/app_color.dart';
import 'package:to_d0_app/home.dart';
import 'package:to_d0_app/models/customTextField.dart';
import 'package:to_d0_app/pages/login_Screen.dart';
import 'package:to_d0_app/providers/USer_Provider.dart';
import 'package:to_d0_app/providers/listProviders.dart';

class RegisterScreen extends StatelessWidget {
  static TextEditingController userNameController = TextEditingController();
  static TextEditingController EmailController = TextEditingController();
  static TextEditingController PasswordController = TextEditingController();
  static TextEditingController confirmController = TextEditingController();

  static const String routName = "register_screen";
  @override
  Widget build(BuildContext context) {
    var listprovider = Provider.of<ListProvidder>(context);
    var Userprovider = Provider.of<UserProvider>(context, listen: false);

    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Account',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(
                    labelText: "User Name",
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "please Enter UserName";
                      }
                      return null;
                    },
                    textController: userNameController,
                    keyboardType: TextInputType.text,
                    scure: false),
                SizedBox(height: 16),
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
                CustomTextField(
                    labelText: "Confirm Password",
                    validator: (text) {
                      if (text != PasswordController.text) {
                        return "Not same password";
                      }
                      return null;
                    },
                    textController: confirmController,
                    keyboardType: TextInputType.number,
                    scure: true),
                SizedBox(height: 16),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        final credential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: EmailController.text,
                          password: PasswordController.text,
                        );
                        Userr user = Userr(
                            name: userNameController.text,
                            id: credential.user!.uid,
                            email: EmailController.text,
                            password: PasswordController.text);
                        Firestore.AddUserToFireStore(user);

                        var useer = await Firestore.ReadUserFireStore(
                            credential.user!.uid);
                        if (useer == null) {
                          return;
                        }
                        Userprovider.ChangeUser(user);
                        listprovider.getAllTasksFromFireStore(
                            Userprovider.currentUser!.id);

                        
                        Navigator.pushReplacementNamed(context, Home.routName);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('The password provided is too weak.')),
                    );
                          print('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('The account already exists for that email.')),
                    );
                          print('The account already exists for that email.');
                        }
                      } catch (e) {
                        print(e);
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('User Added')),
                      );
                    }
                    // Implement registration logic here
                  },
                  child: Text(
                    'Register',
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
                      Navigator.pushReplacementNamed(context, loginScreen.routName);
                    },
                    child: Text(
                      "Login",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
