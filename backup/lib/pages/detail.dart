import 'package:data_bloc/bloc/contacto_bloc.dart';
import 'package:data_bloc/model/Contacto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Detail extends StatefulWidget {
  const Detail({super.key});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            context.read<ContactoBloc>().add(const FetchTodos());
            Navigator.pop(context);
          },
        ),
        title: Text('Adicionar novo contactos'),
      ),
      body: BlocBuilder<ContactoBloc, ContactoState>(
        builder: (context, state) {
          if ( state is MostrarContactoEspecificoState)
          {
            Contacto contacto = state.contacto;
            return Center(
            child: Text(' ${contacto.nome} + ${contacto.telefone} '),
           );
          }
          return Container();
        },
      ),
    );
  }
}
