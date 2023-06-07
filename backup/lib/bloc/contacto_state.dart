part of 'contacto_bloc.dart';

abstract class ContactoState extends Equatable {
  const ContactoState();
  
}

class ContactoInitial extends ContactoState {
   @override
  List<Object> get props => [];
}

class LoadAllContactoState extends ContactoState{

  final List<Contacto> contacto;

  const LoadAllContactoState({ required this.contacto});

  @override
  List<Object> get props => [contacto];
}


class MostrarContactoEspecificoState extends ContactoState {

  final Contacto contacto;

  MostrarContactoEspecificoState( { required this.contacto});

  @override
  List<Object> get props => [contacto];

}
