class Contacto{

  final int? id;
  final String nome;
  final String telefone;

  Contacto({
    this.id, 
    required this.nome,
    required this.telefone,
  });

  Contacto.fromMap(Map<String, dynamic> map):
  id = map["id"] as int,
  nome = map["nome"],
  telefone = map["telefone"];

  Map<String, Object?> toMap() {               // This Function helps to convert our User Object into a Map.
    return {
      "id": id,
      "nome": this.nome,
      "telefone": this.telefone,
    };
  }
}