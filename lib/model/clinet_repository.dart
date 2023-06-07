import 'client.dart';

class ClientRespository{

  final List<Client> _clients = [];

  List<Client> loadClientes(){

    _clients.addAll(
      [
        Client(nome: 'Jussy'),
        Client(nome: 'Leite'),
        Client(nome: 'Thanos'),
        Client(nome: 'Francisco'),
      ]);
      return _clients;
  }

  List<Client> addCliente(Client client)
  {
    _clients.add(client);
    return _clients;
  }

  List<Client> removeCliente(Client client)
  {
    _clients.remove(client);
    return _clients;
  }
}