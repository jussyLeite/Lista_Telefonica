class Contacto{

  final String nome;
  final String telefone;

  Contacto({
    required this.nome,
    required this.telefone,
  });

  Contacto.fromMap(Map map):
  nome = map["nome"],
  telefone = map["telefone"];

  Map toMap() {               // This Function helps to convert our User Object into a Map.
    return {
      "nome": this.nome,
      "telefone": this.telefone,
    };
  }

}