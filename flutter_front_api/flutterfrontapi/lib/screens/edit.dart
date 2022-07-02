import 'package:flutter/material.dart';
import 'package:flutterfrontapi/model/usuario.dart';
import 'package:flutterfrontapi/services/controller_user.dart';

class EditUser extends StatefulWidget {
  final Usuario usuario;
  const EditUser({Key key, this.usuario}) : super(key: key);

  @override
  State<EditUser> createState() => _EditUserState();
}

bool exibe = false;

TextEditingController controllernome = TextEditingController();
TextEditingController controllersenha = TextEditingController();
TextEditingController controlleremail = TextEditingController();

class _EditUserState extends State<EditUser> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    controllernome.text = widget.usuario.nome;
    controllersenha.text = widget.usuario.senha;
    controlleremail.text = widget.usuario.email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Editar Usuário"),
          backgroundColor: Colors.green,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(60, 20, 60, 0),
            child: ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                ),
                TextFormField(
                  controller: controllernome,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo Obrigatório';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: '...',
                    labelText: 'Nome',
                    suffixIcon: Icon(Icons.person, color: Colors.green),
                  ),
                ),
                TextFormField(
                  controller: controllersenha,
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
                TextFormField(
                  controller: controlleremail,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    bool A = false;
                    int point = 0;
                    for (int i = 0; i < value.toString().length; i++) {
                      if (A == false && value.toString()[i] == '@') {
                        for (int j = i; j < value.toString().length; j++) {
                          if (value.toString()[j] == '.' &&
                              (i < value.toString().length - 2 ||
                                  i < value.toString().length - 3)) {
                            point++;
                            if (point == 1) A = true;
                          }
                        }
                      }
                    }
                    if (value == null || value.isEmpty || A == false) {
                      return 'Campo Obrigatório';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'email@gmail.com',
                    labelText: 'E-mail',
                    suffixIcon: Icon(Icons.pending, color: Colors.green),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.all(20),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    onPrimary: Colors.green[50],
                  ),
                  onPressed: () async {
                    Usuario usuario = Usuario(
                        id: widget.usuario.id,
                        nome: controllernome.text,
                        senha: controllersenha.text,
                        email: controlleremail.text);
                    await editUser(usuario);
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Salvar',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
