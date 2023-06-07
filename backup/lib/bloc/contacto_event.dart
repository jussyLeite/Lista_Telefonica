part of 'contacto_bloc.dart';

abstract class ContactoEvent extends Equatable {
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
  final String id;

  FetchSpecificContacto( { required this.id });

   @override
   List<Object> get props => [id];
}