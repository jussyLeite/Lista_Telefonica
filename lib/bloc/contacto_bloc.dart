import 'package:bloc/bloc.dart';
import 'package:data_bloc/model/contacto_repository.dart';
import 'package:data_bloc/services/database_source.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/Constants.dart';
import '../model/Contacto.dart';

part 'contacto_event.dart';
part 'contacto_state.dart';

class ContactoBloc extends Bloc<ContactoEvent, ContactoState> {


  final _contactoRepo = ContactoRespository();
  late DatabaseSource _databaseSource;
  late SharedPreferences? pres;

  ContactoBloc() : super(ContactoInitial()) {
    List<Contacto> contactos = [];
    _databaseSource = DatabaseSource();
    _databaseSource.initializedDB();

    on<FetchTodos>((event, emit) async {
      //contactos = await _contactoRepo.loadClientes();

      contactos = await _databaseSource.getItems(); 

      emit(LoadAllContactoState(contacto: contactos));
    });

    on<AddContacto>((event, emit) async {
      print("${event.nome} ${event.telefone}");
      print("AddContact ...");

      //contactos.add(value)

      _databaseSource.createItem(Contacto(nome: event.nome, telefone: event.telefone));

      contactos = await _contactoRepo.addCliente(Contacto(nome: event.nome, telefone: event.telefone));
    },);

    on<FetchSpecificContacto>((event, emit) async {
        int id = event.id;
        Contacto contactospefic = await _databaseSource.getItem(id);
        emit(MostrarContactoEspecificoState(contacto: contactospefic));
    },);

    on<DarkModeEvent>(((event, emit) async {
      pres = await SharedPreferences.getInstance();
      pres!.setBool("isDark", event.isDark);
      print(pres!.get("isDark"));
    
      //Constants.background(event.isDark);
    

      print("FarModeEvent");
  }));
   on<DeleteContactoEvent>((event, emit) {
    int id = event.id;
     _databaseSource.delete(id);
   },);


}
}