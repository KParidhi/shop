import 'package:home/pages/HomePage.dart';
import 'package:home/pages/SignUpPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:home/pages/forgotPasswordPage.dart';
import 'package:home/services/Auth_Service.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LoginPage extends StatefulWidget{
  LoginPage({ super.key });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  bool circular =false;
  late AuthClass authClass;
  void asyncButtonItem() async {
    authClass = AuthClass();
    await authClass.googleSignIn(context);
  }
  late SharedPreferences logindata;
  late bool newuser;

  @override
  void initState() {
    super.initState();
    check_if_already_login();
  }


  @override
  void dispose()
  {
    _emailController.dispose();
    _pwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    home:
      Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height:MediaQuery.of(context).size.height ,
          width: MediaQuery.of(context).size.width,
          color: Colors.orange,
          child: Column(
            mainAxisAlignment:MainAxisAlignment.center ,
            children: [
              Text("Login page",
                style: TextStyle(
                  fontSize:35,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline
                ),),
              SizedBox(
                height: 20,
              ),
              buttonItem("images/googleIcon.png","continue with google",25),
              SizedBox(
                height: 10,
              ),
              Text("OR",style: TextStyle(color: Colors.white,fontSize: 20),

              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: textItem("Email...",_emailController,false),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: textItem("Password...",_pwdController,true),
              ),

              SizedBox(
                height: 30,
              ),
              colorButton(),
              SizedBox(height: 20,),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("If you don't have an account?  ",
                    style: TextStyle(color: Colors.white,fontSize: 20),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (builder)=>SignUpPage()),
                              (route) => false);
                    },
                    child:
                    Text("Sign Up",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight:FontWeight.bold ,
                      decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
        //forget_Password_Button
         GestureDetector(
           child:Text(
             "Forgot Password?",
             style: TextStyle(
               decoration: TextDecoration.underline,
                 color: Colors.white,
               fontSize: 20,
             ),
           ),
           onTap: ()=>Navigator.of(context).push(MaterialPageRoute(
               builder: (context)=>ForgotPasswordPage(),
           )),
         )



            ],
          ),
        ),
      ),
      ),
    );

  }


  Widget colorButton(){
    return InkWell(
      onTap: () async {
        setState(() {
          circular = true;
        });
        try {
          firebase_auth.UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
              email:_emailController.text, password:_pwdController.text);

          print(userCredential.user?.email);
          setState(() {
            circular=false;
          });
          if(_emailController!='' && _pwdController!=''){
            print('successful');
            logindata.setBool('login', false);
            logindata.setString('Email...', _emailController.text);
          }
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (builder)=>HomePage()) ,
                  (route) => false);
        }
        catch (e) {

        }
      },
      child:Container(
        width: MediaQuery.of(context).size.width - 90,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color:Colors.black,
        ),
        child:Center(
          child:
          Text("Login",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),),
        ),) ,
    );
  }
  Widget buttonItem(String imagepath,String buttonName,double size) {
    return InkWell(
      onTap:(){asyncButtonItem();},
      child:
      Container(
        width: MediaQuery.of(context).size.width - 60,
        height: 60,

        child: Card(
          elevation: 8,
          color: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
                width: 1,
                color: Colors.black),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagepath,
                height: size,
                width: size,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                buttonName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),),
            ],
          ),
        ),
      ),
    );

  }
  Widget textItem(String labeltext,TextEditingController controller,bool obscureText)
  {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height:55,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(
          fontSize:17,color: Colors.white,
        ),
        decoration:InputDecoration(
          labelText: labeltext,labelStyle: TextStyle(
          fontSize:17,color: Colors.white,
        ),
          focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
                width: 1.5,
                color: Colors.black),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
                width: 1,
                color: Colors.black),
          ),
        ),


      ),
    );
  }
void check_if_already_login() async {
  logindata = await SharedPreferences.getInstance();
  newuser = (logindata.getBool('login') ?? true);
  print(newuser);
  if (newuser == false) {
    Navigator.pushAndRemoveUntil(context,
        new MaterialPageRoute(builder: (context) => HomePage()),
            (route)=>false);
  }
}
}





