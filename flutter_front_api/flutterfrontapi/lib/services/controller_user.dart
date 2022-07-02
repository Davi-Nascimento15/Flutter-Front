import 'package:flutterfrontapi/model/usuario.dart';
import 'package:http/http.dart' as http;

String url = 'http://localhost:3000/usuarios';

Future<List<Usuario>> listUser() async {
  final response = await http.get(url);
  return postFromJson(response.body);
}

Future<http.Response> createUser(Usuario usuario) async {
  final response = await http.post(url,
      headers: {"content-type": "application/json"},
      body: usuarioToJson(usuario));
  return response;
}

Future<http.Response> editUser(Usuario usuario) async {
  final response = await http.put(
    '$url/${usuario.id}',
    headers: {'content-type': 'application/json'},
    body: usuarioToJson(usuario),
  );
  return response;
}

Future<http.Response> deleteUser(String id) async {
  final response = await http.delete('$url/$id');
  return response;
}
