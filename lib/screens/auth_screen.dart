import 'package:chat/models/auth_data.dart';
import 'package:chat/widgets/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  bool _isLoading = false;

  Future<void> _handleSubmit(AuthData authData) async {
    setState(() {
      _isLoading = true;
    });

    AuthResult authResult; 
    try {
      if(authData.isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: authData.email.trim(),
          password: authData.password
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: authData.email.trim(),
          password: authData.password
        );

        final userData = {
          'name': authData.name,
          'amail': authData.email,
        };

        // aqui esta persistindo tambem o nome do usuario 
        await Firestore.instance
          .collection('users') // criando um novo document do tipo users
          .document(authResult.user.uid) // pega o id do usuario que esta no Firebase
          .setData(userData);
      }
    } on PlatformException catch(error) {
      final msg = error.message ?? 'Ocorreu um erro, verifique suas credenciais!!';
      _scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(msg),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    } catch(error) {
      print(error);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      backgroundColor: Theme.of(context).primaryColor,
      // body: AuthForm(_handleSubmit),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                AuthForm(_handleSubmit),
                if(_isLoading)
                  Positioned.fill(
                    child: Container(
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                      ),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}