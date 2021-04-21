import 'package:chat/models/auth_data.dart';
import 'package:chat/widgets/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthData authData) onSubmit;

  AuthForm(this.onSubmit);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _formState = GlobalKey();
  final AuthData _authData = AuthData();

  _submit() {
    bool isValid = _formState.currentState.validate();
    FocusScope.of(context).unfocus();

    if(isValid) {
      widget.onSubmit(_authData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formState,
              child: Column(
                children: [
                  if(_authData.isSignup)
                    UserImagePicker(),
                  if(_authData.isSignup)
                    TextFormField(
                      key: ValueKey('name'),
                      initialValue: _authData.name,
                      decoration: InputDecoration(
                        labelText: 'Nome',
                      ),
                      onChanged: (value) => _authData.name = value,
                      validator: (value) {
                        if(value == null || value.trim().length < 4) {
                          return 'Nome inválido';
                        }
                        return null;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('email'),
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                    ),
                    onChanged: (value) => _authData.email = value,
                    validator: (value) {
                        if(value == null || !value.contains('@')) {
                          return 'E-mail inválido';
                        }
                        return null;
                      },
                  ),
                  TextFormField(
                    key: ValueKey('password'),
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                    ),
                    onChanged: (value) => _authData.password = value,
                    validator: (value) {
                        if(value == null || value.trim().length < 7) {
                          return 'Senha inválida';
                        }
                        return null;
                      },
                  ),
                  SizedBox(height: 12),
                  RaisedButton(
                    child: Text(_authData.isLogin ? 'Entrar' : 'Cadastrar'),
                    onPressed: _submit,
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      setState(() {
                        _authData.toggleMode();
                      });
                    }, 
                    child: Text(_authData.isLogin ? 'Criar uma nova conta?' : 'Já possui uma nova conta?'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}