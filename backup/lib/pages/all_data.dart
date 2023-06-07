// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:data_bloc/pages/add.dart';
import 'package:flutter/material.dart';
import '../bloc/contacto_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../pages/detail.dart';

class AllData extends StatefulWidget {
  const AllData({super.key});

  @override
  State<AllData> createState() => _AllDataState();
}

class _AllDataState extends State<AllData> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contactos'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (c) => Add()));
              },
              icon: Icon(Icons.person_add)),
              IconButton(
              onPressed: () {
                context.read<ContactoBloc>().add(FetchTodos());
              },
              icon: Icon(Icons.replay))
        ],
      ),
      body: BlocBuilder<ContactoBloc, ContactoState>(
        builder: (context, state) {

          if (state is ContactoInitial) {
            context.read<ContactoBloc>().add(const FetchTodos());
          } 

          if (state is LoadAllContactoState)
          {
            return ListView.builder(
              itemCount:  state.contacto.length,
              itemBuilder: (context, index){
                return ListTile(
                  leading: CircleAvatar(
                          child: ClipRRect(
                          child: Text(state.contacto[index].nome.substring(0, 1)),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                  title: Text(
                      state.contacto[index].nome + state.contacto[index].telefone
                  ),
                  onTap: (){

                    context.read<ContactoBloc>().add(
                      FetchSpecificContacto(id: state.contacto[index].nome)
                    );
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Detail()),
                    );
                  },
                );
              });
          }
          return Center(
            child: Text('Contactos Error'),
          );
          
        },
      ),
    );
  }
}
