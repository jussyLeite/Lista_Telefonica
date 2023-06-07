import 'package:data_bloc/model/Contacto.dart';

import 'client.dart';

class ContactoRespository{

  final List<Contacto> _contacto = [
   
  ];

  List<Contacto> loadClientes(){

      return _contacto;
  }

  List<Contacto> addCliente(Contacto contacto)
  {
    _contacto.add(contacto);
    return _contacto;
  }

  List<Contacto> removeCliente(Contacto contacto)
  {
    _contacto.remove(contacto);
    return _contacto;
  }
}