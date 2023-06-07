part of 'contacto_bloc.dart';

abstract class ContactoEvent {
  const ContactoEvent();
}


class FetchTodos extends ContactoEvent {
  const FetchTodos();

  @override
  List<Object?> get props => [];
}


class AddContacto extends ContactoEvent{

  final String nome;
  final String telefone;

  AddContacto({
    required this.nome,
    required this.telefone
  });

  @override
  List<Object> get props => [nome, telefone];

}


class FetchSpecificContacto extends ContactoEvent {
  final int id;

  FetchSpecificContacto( { required this.id });

   @override
   List<Object> get props => [id];
}

class DarkModeEvent extends ContactoEvent{
  final bool isDark;

  DarkModeEvent({ required  this.isDark});

   @override
   List<Object> get props => [isDark];

}

class DeleteContactoEvent extends ContactoEvent {

  final int id;

  DeleteContactoEvent({ required this.id });

   @override
   List<Object> get props => [id];


}
 