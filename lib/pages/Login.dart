import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart'; // Import PocketBase library
import 'package:ubuapp/pages/myhomepage.dart';
import 'package:ubuapp/utilities/constants.dart';

final pb = PocketBase(
    'http://127.0.0.1:8090'); // Initialize PocketBase with your server URL

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>(); // Add a GlobalKey for the form
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/background.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 30,
                      width: 80,
                      height: 200,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/light-1.png'),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 140,
                      width: 80,
                      height: 150,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/light-2.png'),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 40,
                      top: 40,
                      width: 80,
                      height: 150,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/clock.png'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _buildEmailTF(),
                        _buildPasswordTF(),
                        _buildRememberMeCheckbox(),
                        _buildLoginBtn(),
                        _buildSignInWithText(),
                        _buildSocialBtnRow(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle.copyWith(
              color: Color.fromARGB(255, 45, 37, 153),)
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Color.fromARGB(255, 45, 37, 153),
              ),
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle.copyWith(
              color: Color.fromARGB(255, 45, 37, 153),)
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: passwordController,
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: const Color.fromARGB(255, 45, 37, 153),
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 60.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(
                unselectedWidgetColor: Color.fromARGB(255, 149, 144, 224)),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.white,
              activeColor: Color.fromARGB(255, 149, 144, 224),
              onChanged: (value) {
                setState(() {
                  _rememberMe = value!;
                });
              },
            ),
          ),
          Text(
            'Remember me',
            style: kLabelStyle.copyWith(
              color: Color.fromARGB(255, 149, 144, 224),
            ),
          ),
        ],
      ),
    );
  }

  bool _rememberMe = false; // Add the _rememberMe variable

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          // Get the user's input for email and password
          final email = emailController.text;
          final password = passwordController.text;

          // Print the email and password for debugging purposes
          print('Email: $email');
          print('Password: $password');

          // Check if the email is valid
          if (!isValidEmail(email)) {
            // Show an error message for invalid email
            showErrorDialog('Invalid email format');
            return;
          }

          // Check if the password meets your criteria (e.g., minimum length)
          if (password.length < 6) {
            // Show an error message for weak password
            showErrorDialog('Password must be at least 6 characters long');
            return;
          }

          try {
            // Authenticate with PocketBase
            final authData = await pb.admins.authWithPassword(email, password);

            // Check if authentication was successful
            if (authData != null) {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeView()));
              // Do something after successful login (e.g., navigate to another screen)
            } else {
              // Handle authentication failure and show an error dialog
              showErrorDialog('Authentication failed');
            }
          } catch (error) {
            // Handle any exceptions that may occur during authentication
            print('Authentication Error: $error');

            // Show an error dialog with the error message
            showErrorDialog('Authentication error');
          }
        },
        style: ElevatedButton.styleFrom(
          elevation: 5.0,
          padding: EdgeInsets.all(25.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          primary: Colors.white,
        ),
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Color.fromARGB(255, 113, 105, 218),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  // Function to validate email format
  bool isValidEmail(String email) {
    // You can use a regular expression for email validation
    // Here's a simple example:
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(email);
  }

  // Function to show an error dialog
  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        Text(
          '- OR -',
          style: TextStyle(
            color: const Color.fromARGB(255, 149, 144, 224),
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          'Sign in with',
          style: kLabelStyle.copyWith(
            color: Color.fromARGB(255, 149, 144, 224),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
            onTap: () => print('Login with Facebook'),
            child: Container(
              width: 50.0, // Set your desired width for the Facebook button
              height: 50.0, // Set your desired height for the Facebook button
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 234, 227,
                    255), // You can set your desired button color here
              ),
              child: Center(
                child: Image(
                  image: AssetImage('icons/facebook.png'),
                  width: 30.0, // Set your desired width for the Facebook icon
                  height: 30.0, // Set your desired height for the Facebook icon
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => print('Login with Google'),
            child: Container(
              width: 50.0, // Set your desired width for the Google button
              height: 50.0, // Set your desired height for the Google button
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 234, 227,
                    255), // You can set your desired button color here
              ),
              child: Center(
                child: Image(
                  image: AssetImage('icons/google.png'),
                  width: 30.0, // Set your desired width for the Google icon
                  height: 30.0, // Set your desired height for the Google icon
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
