import 'package:attend/core/values/attend_colors.dart';
import 'package:attend/features/home_screen.dart';
import 'package:attend/features/login/login_controller.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage();

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _controller = LoginControllerImpl();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Atendimento ao Coordenador",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => email = value,
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Senha'),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                onChanged: (value) => password = value,
              ),
              SizedBox(
                height: 32,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(Size(double.infinity, 50)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          AttendColors.unity_container),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                              color: AttendColors.unity_container)))),
                  onPressed: () {
                    _controller.login(email, password).then((value) => {
                          if (value)
                            {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()))
                            }
                          else
                            {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "Erro ao logar! Verifique seus dados.")))
                            }
                        });
                  },
                  child: Text(
                    "Entrar",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ))
            ],
          ),
        ),
      )),
    );
  }
}
