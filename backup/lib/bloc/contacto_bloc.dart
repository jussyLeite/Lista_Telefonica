import 'package:bloc/bloc.dart';
import 'package:data_bloc/services/database_source.dart';
import 'package:equatable/equatable.dart';

import '../model/Contacto.dart';

part 'contacto_event.dart';
part 'contacto_state.dart';

class ContactoBloc extends Bloc<ContactoEvent, ContactoState> {

   List<Contacto> contacto = [];

  ContactoBloc() : super(ContactoInitial()) {
    on<FetchTodos>((event, emit) {
     
      //todos = await DatabaseService.instance.readAllTodos();
      print("Fetc all ...");
      
      emit(LoadAllContactoState(contacto: contacto));
    });

    on<AddContacto>((event, emit) {
      print("${event.nome} ${event.telefone}");
      print("AddContact ...");


      contacto.add(Contacto(nome: event.nome, telefone: event.telefone));
    },);

    on<FetchSpecificContacto>((event, emit) {
        String id = event.id;


        Contacto contacto = Contacto(nome: "Jussy", telefone: "9830");
        emit(MostrarContactoEspecificoState(contacto: contacto));
    },);
  }
}
