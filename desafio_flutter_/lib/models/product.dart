
class Product {
  int? id;
  String nome;
  String descricao;
  double preco;
  String dataAtualizado;

  Product({this.id, required this.nome, required this.descricao, required this.preco, required this.dataAtualizado});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'],
    nome: json['nome'],
    descricao: json['descricao'],
    //preco: (json['preco'] as num).toDouble(),
    preco: double.parse(json['preco'].toString()),
    dataAtualizado: json['data_atualizado']
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'descricao': descricao,
    'preco': preco,
    'data_atualizado': dataAtualizado
  };
}
