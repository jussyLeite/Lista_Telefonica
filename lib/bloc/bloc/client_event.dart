part of 'client_bloc.dart';


abstract class ClientEvent{
  const ClientEvent();

  @override
  List<Object> get props => [];

}


class LoadClientEvent extends ClientEvent {}


class AddClientEvent extends ClientEvent {
  Client client;

  AddClientEvent({
    required this.client
  });
}


class RemoveClientEvent extends ClientEvent {
  Client client;

  RemoveClientEvent({
    required this.client
  });
}


