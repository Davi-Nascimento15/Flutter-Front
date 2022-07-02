import 'package:flutter/material.dart';
import 'package:flutterfrontapi/model/usuario.dart';
import 'package:flutterfrontapi/screens/create.dart';
import 'package:flutterfrontapi/screens/edit.dart';
import 'package:flutterfrontapi/services/controller_user.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios Cadastrados'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.power_settings_new_rounded))
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder(
          future: listUser(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              var response = snapshot.data as List<Usuario>;
              return ListView.builder(
                itemCount: response.length,
                itemBuilder: (context, index) {
                  var usuarioItem = response[index];
                  return ListTile(
                    title: Text(usuarioItem.nome),
                    leading: const Icon(
                      Icons.person,
                      color: Colors.green,
                    ),
                    trailing: Wrap(
                      spacing: 12,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () async {
                            Usuario usuario = Usuario(
                                id: usuarioItem.id,
                                nome: usuarioItem.nome,
                                senha: usuarioItem.senha,
                                email: usuarioItem.email);
                            await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return EditUser(usuario: usuario);
                              }),
                            );
                            setState(() {});
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.white,
                                    title: const Text(
                                      "Atenção",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: const Text(
                                        'Tem certeza que deseja excluir?'),
                                    actions: [
                                      TextButton(
                                        child: const Text(
                                          'Sim',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onPressed: () async {
                                          await deleteUser(usuarioItem.id);
                                          setState(() {
                                            Navigator.pop(context);
                                          });
                                        },
                                      ),
                                      TextButton(
                                        child: const Text(
                                          'Não',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                });
                          },
                        )
                      ],
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                usuarioItem.nome,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      const Text(
                                        'Email: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red),
                                      ),
                                      Text(usuarioItem.email),
                                    ]),
                                    Row(
                                      children: [
                                        const Text(
                                          'Senha: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red),
                                        ),
                                        Text(usuarioItem.senha)
                                      ],
                                    )
                                  ]),
                              actions: [
                                TextButton(
                                  child: const Text(
                                    'Voltar',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            );
                          });
                    },
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.person_add),
        onPressed: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CreateUser()));
          setState(() {});
        },
        backgroundColor: Colors.green,
      ),
    );
  }
}
