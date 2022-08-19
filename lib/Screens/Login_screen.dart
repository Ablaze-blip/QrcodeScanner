import 'package:bus_pedal_conductor/Screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  //form key
  final _formkey = GlobalKey<FormState>();

  //editing Controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController companyNameController = new TextEditingController();

  //firebase
  final _auth = FirebaseAuth.instance;




  @override
  Widget build(BuildContext context) {

    //emailfield
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if(value!.isEmpty)
          {
            return ("Please Enter Your Email");
          }
        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
            .hasMatch(value)) {
          return ("please enter a valid email");
        }
        return null;
      },
      onSaved: (value){
        emailController.text = value!;

      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mark_email_read_rounded),
        contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        )

      ));

    //company field
    final companyNameField = TextFormField(
      autofocus: false,
      controller: companyNameController,

      validator: (value) {
        if(value!.isEmpty)
        {
          return ("Please Enter The Exact Company Name");
        }
        // reg expression for company Name validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
            .hasMatch(value)) {
          return ("please enter a valid Company Name");
        }
        return null;
      },
      onSaved: (value){
        companyNameController.text = value!;

      },
      textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.business_rounded),
            contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
            hintText: "Company Name",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )

        )
    );

    //password field
    final passwordField = TextFormField(
      controller: passwordController,
      obscureText: true,

      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');//minimum value for firebase is 6 for password
        if(value!.isEmpty)
        {
          return("Please enter your Password");

        }
        if(!regex.hasMatch(value))
        {
          return("Please Enter a Valid Password (Min 6 Characters)");
        }


      },
      onSaved: (value){
        passwordController.text = value!;

      },
      textInputAction: TextInputAction.done,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock_outline_rounded),
            contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
            hintText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )

        )
    );

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.pinkAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20,15,20,15),
        minWidth: MediaQuery.of(context).size.width,

        onPressed: () {
          signIn(emailController.text, passwordController.text);
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        },
        child: Text ("Login", textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        )),

    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    SizedBox(
                      height: 200,
                      child: Image.asset("assets/logo.png", fit: BoxFit.contain,)),
                      SizedBox(height: 45),

                    emailField,
                    SizedBox(height: 35),

                    companyNameField,
                    SizedBox(height: 35),

                    passwordField,
                    SizedBox(height: 35),

                    loginButton,
                    SizedBox(height: 15),



                  ]
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // login function
  void signIn(String email, String password, ) async
  {
    if(_formkey.currentState!.validate())
    {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((cid) => {
        Fluttertoast.showToast(msg: "Login Succesful"),
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen())),

      }).catchError((e)
      {
        Fluttertoast.showToast(msg: e!.message);

      });

    }
  }


}

