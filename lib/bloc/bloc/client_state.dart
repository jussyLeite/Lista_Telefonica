part of 'client_bloc.dart';

abstract class ClientState {
  List<Client> clients;
   ClientState({
    required this.clients
  });
  
  @override
  List<Object> get props => [];
}

class ClientInitial extends ClientState {

      ClientInitial() :super(clients: []); 
}

class ClientSucessState extends ClientState {
    ClientSucessState({required List<Client> clients}) :super(clients: clients); 
    
}



