import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadUserEvent extends SearchEvent {
  final String userId;

  LoadUserEvent({this.userId});

  @override
  List<Object> get props => [userId];
}

class ViewUserEvent extends SearchEvent {
  final String currentUserId, name, bio, photoUrl;

  ViewUserEvent({this.currentUserId, this.name, this.bio, this.photoUrl});

  @override
  List<Object> get props => [currentUserId, name, bio, photoUrl];
}

class SelectUserEvent extends SearchEvent {
  final String currentUserId, selectedUserId, name, photoUrl;

  SelectUserEvent(
      {this.currentUserId, this.name, this.photoUrl, this.selectedUserId});

  @override
  List<Object> get props => [currentUserId, selectedUserId, name, photoUrl];
}

class PassUserEvent extends SearchEvent {
  final String currentUserId, selectedUserId;

  PassUserEvent(this.currentUserId, this.selectedUserId);

  @override
  List<Object> get props => [currentUserId, selectedUserId];
}
