import 'dart:convert';

class Usuario {
  String id;
  String nome;
  String email;
  String senha;

  Usuario({
    this.id,
    this.nome,
    this.email,
    this.senha,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
        id: json['_id'],
        nome: json['nome'],
        senha: json['senha'],
        email: json['email']);
  }

  Map<String, dynamic> toJson() {
    return {"nome": nome, "senha": senha, "email": email};
  }

  @override
  String toString() {
    return 'Post{_id:$id ,nome: $nome ,senha: $senha ,email: $email }';
  }
}

List<Usuario> postFromJson(String strJson) {
  final str = json.decode(strJson);
  return List<Usuario>.from(str.map((item) {
    return Usuario.fromJson(item);
  }));
}

String usuarioToJson(Usuario usuario) {
  final dyn = usuario.toJson();
  return json.encode(dyn);
}
