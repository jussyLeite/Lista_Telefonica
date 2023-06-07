// ignore_for_file: prefer_const_constructors

import 'package:data_bloc/bloc/contacto_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/Contacto.dart';

class Edit extends StatefulWidget {
  const Edit({super.key});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  String nome = " ";
  String telefone = " ";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Adicionar novo contactos'),
        ),
        body: BlocBuilder<ContactoBloc, ContactoState>(
          builder: (context, state) {

            if ( state is MostrarContactoEspecificoState)
          {
            Contacto contacto = state.contacto;

           

          
            return Center(
              child: Column(
                children: <Widget>[
                  Form(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(40)),
                      SizedBox(
                        width: 250,
                        height: 40,
                        child: TextFormField(
                          validator: (value) {
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                          
                            hintText: "",
                          ),
                          onChanged: (value) {
                            nome = value;
                          },
                        ),
                      ),
                      Text(contacto.nome),
                      SizedBox(
                        width: 250,
                        height: 40,
                        child: TextFormField(
                          validator: (value) {
                            return null;
                          },
                          onChanged: (value) {
                            telefone = value;
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.phone),
                              hintText: "Telefone"),
                        ),
                      ),
                      BlocBuilder<ContactoBloc, ContactoState>(
                          builder: (context, state) {
                        return ElevatedButton(
                            onPressed: () {
                              context.read<ContactoBloc>().add(
                                  AddContacto(nome: nome, telefone: telefone));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                duration: Duration(seconds: 1),
                                content: Text("Contacto Adicionadao!"),
                              ));
                              context
                                  .read<ContactoBloc>()
                                  .add(const FetchTodos());
                              Navigator.pop(context);
                            },
                            child: Text('Salvar'));
                      })
                    ],
                  ))
                ],
              ),
            );

          }
          return Container();
          },
        ));
  }
}
