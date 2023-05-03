
import 'package:home/pages/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthClass{
  FirebaseAuth auth= FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<void> googleSignIn( BuildContext context)

  async {
    try {
      GoogleSignInAccount? googleSignInAccount =await  _googleSignIn.signIn();
      if(googleSignInAccount!=null)
      {
        GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
        AuthCredential credential= await GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );
        try{
          UserCredential userCredential=
          await auth.signInWithCredential(credential);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder)=>HomePage()) ,
                  (route) => false);

        }catch(e){
          final snackbar = SnackBar(content:Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);

        }
      }else{
        final snackbar = SnackBar(content:Text("Not able to sign in"));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);

      }
    }
    catch (e) {
      final snackbar = SnackBar(content:Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);

    }
  }
}