import 'package:flutter/material.dart';
import 'package:flutterfrontapi/model/usuario.dart';
import 'package:flutterfrontapi/screens/create.dart';
import 'package:flutterfrontapi/screens/list.dart';
import 'package:flutterfrontapi/services/controller_user.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool exibe = false;
  TextEditingController nome = TextEditingController();
  TextEditingController senha = TextEditingController();
  List<Usuario> usuarios = [];

  bool _validacao(String email, String senha) {
    for (int i = 0; i < usuarios.length; i++) {
      if (usuarios[i].email == email) {
        if (usuarios[i].senha == senha) {
          return true;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: listUser(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            var response = snapshot.data as List<Usuario>;
            for (int i = 0; i < response.length; i++) {
              Usuario usuario = Usuario(
                  id: response[i].id,
                  nome: response[i].nome,
                  senha: response[i].senha,
                  email: response[i].email);
              usuarios.add(usuario);
            }
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(50),
                  alignment: Alignment.center,
                  child: Image.asset(
                    'images/logo.jpg',
                    height: 150,
                    width: 300,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(80, 10, 80, 10),
                  child: TextFormField(
                    controller: nome,
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                      hintText: '...',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(80, 10, 80, 50),
                  child: TextFormField(
                    controller: senha,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      hintText: '...',
                      suffixIcon: GestureDetector(
                        child: Icon(
                            exibe == false
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.green),
                        onTap: () {
                          setState(() {
                            exibe = !exibe;
                          });
                        },
                      ),
                    ),
                    obscureText: exibe == false ? true : false,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    onPrimary: Colors.pink[50],
                  ),
                  onPressed: () {
                    if (_validacao(nome.text, senha.text)) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Home(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                          'Email ou senha incorretos',
                          style: TextStyle(fontSize: 16),
                        ),
                      ));
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Entrar',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextButton(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CreateUser(),
                          ),
                        );
                        setState(() {});
                      },
                      child: Text(
                        'Registre-se',
                        style: TextStyle(
                            color: Colors.blue[800],
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      )),
                )
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
