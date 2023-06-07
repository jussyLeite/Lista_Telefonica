import 'dart:math';

import 'package:data_bloc/bloc/bloc/client_bloc.dart';
import 'package:data_bloc/model/client.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pages/all_data.dart';
import 'bloc/contacto_bloc.dart';



void main() {
  runApp(const MyApp());
}



class MyApp extends StatelessWidget 
{
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ContactoBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AllData(),
      ),
    );  
}
}
  

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final ClientBloc clientBloc = ClientBloc();
  
  int _counter = 0;

  String randomName(){
    final  rand = Random();

    return ['Maria', 'Miguel', 'Jose', 'William'].first;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    clientBloc.add(LoadClientEvent());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    clientBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: (){
              clientBloc.add(AddClientEvent(client: Client(nome: "Marcos")));
            }, 
          icon: Icon(Icons.person_add))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child:  BlocBuilder<ClientBloc,  ClientState>(
                bloc: clientBloc,
                builder: (context, state){
                  if ( state is ClientInitial)
                  {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  else if ( state is ClientSucessState)
                  {
                    final clientsList = state.clients;
                    return ListView.separated(
                      itemBuilder: (context, index) => ListTile(
                        leading: CircleAvatar(
                          child: ClipRRect(
                            child: Text(clientsList[index].nome.substring(0, 1)),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        title: Text(clientsList[index].nome),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: (){
                            clientBloc.add(RemoveClientEvent(client: clientsList[index]));
                          },
                        ),
                      ), 
                      separatorBuilder: (_, __) => Divider(), 
                      itemCount: clientsList.length
                      );
                  }
                  return Center(
                    child: Text('Erros'),
                  );
                }
                )
      
      ),
      
    );
  }
}
