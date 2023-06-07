// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:data_bloc/bloc/contacto_bloc.dart';
import 'package:data_bloc/model/Contacto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/Constants.dart';
import 'edit.dart';


class Detail extends StatefulWidget {
  const Detail({super.key});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {

 
  bool isDark = false;
  Color? cor;
  Color? corIcon, textCor, corAppBar, appBarIcon;
   

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    teste();

  }

  void teste() async {

    SharedPreferences pres = await SharedPreferences.getInstance();
    isDark = pres.getBool("bg") as bool;
  
  }

  void background() async {
    SharedPreferences pres = await SharedPreferences.getInstance();
    pres.setBool("bg", false);

   cor = isDark  ? Colors.grey[900] : Colors.white;
   corIcon = isDark ?  Colors.white :  Colors.grey[900];
   textCor = corIcon;
   corAppBar = isDark ?  Colors.grey[900] :  Colors.blue;
  }

  int? idContacto;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: corAppBar,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, ),
          onPressed: (){
            context.read<ContactoBloc>().add(const FetchTodos());
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(onPressed: (){
            context.read<ContactoBloc>().add(
                  FetchSpecificContacto(id: idContacto!)
                  );

                Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const Edit()),
            );
          }, 
          icon: Icon(Icons.edit,)
        ),
        IconButton(onPressed: (){
             setState(() {
               isDark ? isDark = false :  isDark = true;
               background();
             });
        }, 
        icon: Icon(Icons.dark_mode, )
        )
        ],
        title: Text('Detalhe',
         style: TextStyle(
          fontFamily: Constants.font
         ),
        ),
      ),
      body: BlocBuilder<ContactoBloc, ContactoState>(
        builder: (context, state) {
          if ( state is MostrarContactoEspecificoState)
          {
            Contacto contacto = state.contacto;
            idContacto = contacto.id!;
            return SingleChildScrollView(
              child: Container(
                height: 700,
                decoration: BoxDecoration(
                  color: cor
                ),
                child: Center(
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.all(10.0),),
                      CircleAvatar(
                      child: ClipRRect(
                        child: Text(state.contacto.nome.substring(0,1)),
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                    ),
                    SizedBox(height: 40.0,),
                    Text(' ${contacto.nome}',
                    style: TextStyle(
                      color: textCor,
                      fontSize: 20.0,
                      fontFamily: Constants.font,
                    ),),
              
                    SizedBox(height: 30.0,),
                    Divider(
                      color: corIcon,
                      endIndent: 30.0,
                      indent: 40.0,
                    ),
              
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(onPressed: null, icon: Icon(Icons.call, color: corIcon)),
              
                        Padding(padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0)),
              
                        IconButton(onPressed: null, icon: Icon(Icons.message, color: corIcon,)),
              
                        Padding(padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0)),
              
                        IconButton(onPressed: null, icon: Icon(Icons.favorite, color: Colors.red[700])),
                      ],
                    ),
                     Divider(
                      color: corIcon,
                      endIndent: 30.0,
                      indent: 40.0,
                    ),
                    Container(
                      width: 300,
                      height: 90,
                    
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child:  Center(child: Text(' ${contacto.telefone}',
                      style: TextStyle(
                        
                        fontFamily: Constants.font,
                      ),
                      )),
                    )
                    ],
                  ),
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
