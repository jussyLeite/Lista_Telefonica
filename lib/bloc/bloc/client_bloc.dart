import 'package:bloc/bloc.dart';
import 'package:data_bloc/model/clinet_repository.dart';
import 'package:equatable/equatable.dart';

import '../../model/client.dart';
import '../../model/clinet_repository.dart';
import '../../services/database_source.dart';

part 'client_event.dart';
part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {

  final _clientRepo = ClientRespository();
  late DatabaseSource _databaseSource;


  ClientBloc() : super(ClientInitial()) {
    on<ClientEvent>((event, emit) {
      
    });

      on<LoadClientEvent>((event, emit) {  
       emit(ClientSucessState(clients: _clientRepo.loadClientes()));
       print("Loafing... cliente");
    });

    on<AddClientEvent>((event, emit) {  
       emit(ClientSucessState(clients: _clientRepo.addCliente(event.client)));
       print("Adding... cliente");
    });

     on<RemoveClientEvent>((event, emit) {  
       emit(ClientSucessState(clients: _clientRepo.removeCliente(event.client)));
    });



  }
}
