// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:convert';

import 'package:data_bloc/pages/add.dart';
import 'package:data_bloc/pages/search.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/contacto_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../pages/detail.dart';
import 'package:searchfield/searchfield.dart';
import '../constants/Constants.dart';

class AllData extends StatefulWidget {
  const AllData({super.key});

  @override
  State<AllData> createState() => _AllDataState();
}

class _AllDataState extends State<AllData> {


  
  Color? corAppBar, corIcon, cor, textCor, corCard;
  String font = Constants.font;

   void  background(bool isDark){
   cor = isDark  ? Colors.grey[900] : Colors.white;
   corCard = isDark  ? Colors.grey[800] : Colors.white;
   corIcon = isDark ?  Colors.white :  Colors.grey[900];
   textCor = corIcon; 
   corAppBar = isDark ?  Colors.grey[900] :  Colors.blue;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //background(isDark);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: corAppBar,
        title: Text('Contactos', style: TextStyle(
          fontFamily: font,
        ),),
        actions: <Widget>[
          IconButton(
              onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => const Add()));
        },
              icon: Icon(Icons.person_add)),
              IconButton(
              onPressed: () {
                print("Favoritos");
                /*context.read<ContactoBloc>().add(FetchTodos());*/
              },
              icon: Icon(Icons.favorite, color: Colors.red[700],)),
              
              IconButton(onPressed: () async {

                 SharedPreferences pres = await SharedPreferences.getInstance();
                  bool isDark = await  pres.getBool("isDark")!;
                   
                isDark ? context.read<ContactoBloc>().add( DarkModeEvent(isDark: false)) 
                :
                context.read<ContactoBloc>().add( DarkModeEvent(isDark: true)); 
            
               setState(() {
                   background(isDark);
                }); 
                 
                }, 
               icon: Icon(Icons.dark_mode, 
            )
        )
        ],
      ),
      body: BlocBuilder<ContactoBloc, ContactoState>(
        builder: (context, state) {

          if (state is ContactoInitial) {
            context.read<ContactoBloc>().add(const FetchTodos());
            print("state ContactoInitial");
          } 

          if (state is DarkState )
          {
             background(state.isDark);
          }
          if (state is LoadAllContactoState)
          {
             print("state LoadAllContactoState...");
             return Container(
              height: 700,
                decoration: BoxDecoration(
                color: cor,),
               child: Column(
                 children: [
                   state.contacto.isEmpty ?
                    Column(
                      children: [
                        Padding(padding: EdgeInsets.all(50.0)),
                        Center(
                          child: Image.asset("images/undraw_Contact_us_re_4qqt.png"),
                        ),
                        Text("Você não tem contactos",
                        style: TextStyle(
                          fontFamily: font
                        ),),
                        IconButton(
                        onPressed: () {
                           Navigator.push(
                            context, MaterialPageRoute(builder: (c) => const Add()));
                        },
                        icon: Icon(Icons.person_add, color: Colors.green[700],))
                      ],
                    )
                    : 
                   SizedBox(height: 10.0,),
                   SizedBox(
                    width: 300,
                    height: 40,
                    child: TextFormField(
                      
                      validator: (value){
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search, color: corIcon,),
                        hintText: "pesquisar",
                      ),
             
                      onEditingComplete: (){
                        Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => const Seacrh()),
                              );
                      },
                       onTap: (){
                          Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => const Seacrh()),
                              );
                       },  
                    ),
                  ),
                   SizedBox(height: 20.0,),
                   Expanded(
                     child: ListView.builder(
                      itemCount:  state.contacto.length,
                      itemBuilder: (context, index){
                        return  Card(
                          color: corCard,
                          child: ListTile(
                            leading: CircleAvatar(
                                    child: ClipRRect(
                                    child: Text(state.contacto[index].nome.substring(0, 1), style: TextStyle(
                                      fontFamily: font,
                                    ),),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                            title: Text(
                                state.contacto[index].nome
                                ,style: TextStyle(
                                  color: corIcon,
                                  fontFamily: font,
                                ),
                            ),
                            onLongPress: (){
                              context.read<ContactoBloc>().add(
                                DeleteContactoEvent(id: state.contacto[index].id!));
                                context.read<ContactoBloc>().add(const FetchTodos());

                            },
                            onTap: (){
                                         
                              context.read<ContactoBloc>().add(
                                FetchSpecificContacto(id: state.contacto[index].id!)
                              );
             
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => const Detail()),
                              );
                            },
                          ),
                        );
                      }),
                   ),
                 ],
               ),
             );
          }
          return Center(
            child: Text('Contactos Error'),
          );
        },
      ),
    );
  }
}
