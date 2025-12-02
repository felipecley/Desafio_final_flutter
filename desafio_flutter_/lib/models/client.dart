
class Client {
  int? id;
  String nome;
  String sobrenome;
  String email;
  int idade;
  String foto;

  Client({this.id, required this.nome, required this.sobrenome, required this.email, required this.idade, required this.foto});

  factory Client.fromJson(Map<String, dynamic> json) => Client(
    id: json['id'],
    nome: json['nome'],
    sobrenome: json['sobrenome'],
    email: json['email'],
    idade: json['idade'],
    foto: json['foto']
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'sobrenome': sobrenome,
    'email': email,
    'idade': idade,
    'foto': foto
  };
}
