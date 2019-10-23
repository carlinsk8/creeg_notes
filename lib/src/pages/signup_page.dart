import 'package:flutter/material.dart';
import 'package:note_creeg/src/providers/provider.dart';
import 'package:note_creeg/src/providers/user_provider.dart';
import 'package:note_creeg/src/utils/utils.dart';

class SignUpPage extends StatelessWidget {

  final userProvider = new UserProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _titulo(),
          _loginForm(context),
        ],
      )
    );
  }

  Widget _crearFondo(BuildContext context) {
    final size =  MediaQuery.of(context).size;

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(139, 22, 255, 0.5)
      ),
    );
    final circulolit = Container(
      width: 50.0,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(139, 22, 255, 0.2)
      ),
    );

    return Stack(
      children: <Widget>[
        Positioned(top: 0.0, left: size.width * 0.80, child: circulo,),
        Positioned(top: 0.0, left: size.width * 0.72, child: circulolit,),
        Positioned(top: size.height * 0.5, right: size.width * 0.8, child: circulo,),
        Positioned(top: size.height * 0.5, right: size.width * 0.72, child: circulolit,),
        Positioned(bottom: 0.0, left: size.width * 0.8, child: circulo,),
        Positioned(bottom: 0.0, left: size.width * 0.72, child: circulolit,),

        
      ],
    );
  }
  Widget _titulo() {
    return Container(
      padding: EdgeInsets.only(top: 50.0),
      child: Column(
        children: <Widget>[
          Icon(Icons.person_pin, color: Color.fromRGBO(139, 22, 255, 1.0), size: 100.0,),
          SizedBox(height: 10.0, width: double.infinity,),
          Text('Creeg Notes', style: TextStyle(fontSize: 25.0, color: Color.fromRGBO(139, 22, 255, 1.0), ),)
        ],
      ),
    );
   }

  Widget _loginForm(BuildContext context) {
    
    final bloc = Provider.of(context);
    final size =  MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(height: 180.0,),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.8),
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(1.0, 5.0),
                  spreadRadius: 3.0
                )
              ]
                
              
            ),
            child: Column(
              children: <Widget>[
                Text('SingUp', style: TextStyle(fontSize: 20.0),),
                SizedBox(height: 30.0,),
                _inputEmail(bloc),
                SizedBox(height: 30.0,),
                _inputPassword(bloc),
                SizedBox(height: 30.0,),
                _inputButton(bloc)
              ],
            ),
          ),
          FlatButton(
            child: Text('Sing in?'),
            onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
          ),
          SizedBox(height: 100.0,)
        ],
      ),
    );
  }

  Widget _inputEmail(LoginBloc bloc) {

    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),

        child: TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            icon: Icon( Icons.alternate_email, color: Colors.deepPurple ),
            hintText: 'example@email.com',
              labelText: 'Email',
            counterText: snapshot.data,
            errorText: snapshot.error
          ),
          onChanged: bloc.changeEmail,
        ),

      );


      },
    );
  }
  Widget _inputPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),

          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon( Icons.lock_outline, color: Colors.deepPurple ),
              labelText: 'Password',
              counterText: snapshot.data,
              errorText: snapshot.error
            ),
            onChanged: bloc.changePassword,
          ),

        );

      },
    );
    
  }

  Widget _inputButton(LoginBloc bloc) {
     return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric( horizontal: 80.0, vertical: 15.0),
            child: Text('Ingresar'),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
          ),
          elevation: 0.0,
          color: Colors.deepPurple,
          textColor: Colors.white,
          onPressed: snapshot.hasData ? ()=> _signUp(context,bloc) : null
        );
      },
    );
    
  }
  _signUp(BuildContext context,LoginBloc bloc) async {
    Map info = await userProvider.newUser(bloc.email, bloc.password);

    if(info['ok']){
      Navigator.pushReplacementNamed(context, 'login');
    }else{
      showAlert(context, info['message']);
    }
  }
}