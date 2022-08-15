import 'package:finalyearproject/controllers/firebase_form.dart';
import 'package:finalyearproject/pages/dashboard.dart';
import 'package:finalyearproject/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool? isRememberMe = false;
  String? _email, _password;

  FirebaseForm formController = Get.find();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFB0BEC5),
              Color(0xFF90A4AE),
              Color(0xFF78909C),
              Color(0xFF607D8B),
            ],
          ),
        ),
        child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Column(
                    children: <Widget>[
                      const Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Email',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black87,
                                  blurRadius: 6,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            height: 60,
                            child: TextFormField(
                              onSaved: ((newValue) {
                                _email = newValue;
                              }),
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(
                                color: Colors.black87,
                              ),
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 14),
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.blueGrey,
                                  ),
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                    color: Colors.black38,
                                    fontStyle: FontStyle.italic,
                                  )),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Password',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black87,
                                  blurRadius: 6,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            height: 60,
                            child: TextFormField(
                              onSaved: ((newValue) {
                                _password = newValue;
                              }),
                              obscureText: true,
                              style: const TextStyle(
                                color: Colors.black87,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14),
                                prefixIcon: Icon(
                                  Icons.vpn_key,
                                  color: Colors.blueGrey,
                                ),
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                  color: Colors.black38,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 20.0,
                        child: Row(
                          children: <Widget>[
                            Theme(
                              data:
                                  ThemeData(unselectedWidgetColor: Colors.white),
                              child: Checkbox(
                                value: isRememberMe,
                                checkColor: Colors.blueGrey,
                                activeColor: Colors.white,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      isRememberMe = value;
                                    },
                                  );
                                },
                              ),
                            ),
                            const Text(
                              'Remember me',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            elevation: 5,
                            padding: const EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {
                            formController.login(_email, _password);
                            Get.to(const DashBoard());
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Don\'t have an Account? ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(const SignUpPage());
                            },
                            child: const Text(
                              'SignUp',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
