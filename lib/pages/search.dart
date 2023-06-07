// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/contacto_bloc.dart';
import '../model/Contacto.dart';
import 'detail.dart';

class Seacrh extends StatefulWidget {
  const Seacrh({super.key});

  @override
  State<Seacrh> createState() => _SeacrhState();
}

class _SeacrhState extends State<Seacrh> {
  
  
  List<Contacto> sugestContacto = [];
  List<Contacto> items = [];

  @override
  Widget build(BuildContext context) {


    void filterSearchResults(String query) {
      setState(() {
        items = sugestContacto
            .where((item) => item.nome.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('search'),
        ),
        body: BlocBuilder<ContactoBloc, ContactoState>(
          builder: (context, state) {

            if ( state is LoadAllContactoState )
            {
              sugestContacto.isEmpty ? sugestContacto.addAll(state.contacto) : print("");
                
                    return Center(
                      child: Column(
                        children: [
                          SizedBox(
                            width: 300,
                            height: 40,
                            child: TextFormField(
                              validator: (value) {
                                return null;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.search),
                                hintText: "pesquisar",
                              ),
                              onChanged: (value){
                                filterSearchResults(value);
                                print(" len ${items.length}");
                              },
                            ),
                          ),
                          SizedBox(height: 30.7,),

                         items.isEmpty ? 
                           Expanded(child: Center(
                                  child: Column(children: [
          
                                    Text("Nenhum Resultado Encontrado!"),
                                  ],)
                           ))
                         :
                          Expanded(child: ListView.builder(
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50.0),
                                      child: Text(items[index].nome.substring(0,1)),
                                    ),
                                  ),
                                  title: Text(items[index].nome),
                                  onTap: () {
                                    context.read<ContactoBloc>().add(
                                        FetchSpecificContacto(id: items[index].id!)
                                      );
                                      Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => const Detail()),
                                      );
                                  },
                                ),
                              );
                            },
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
