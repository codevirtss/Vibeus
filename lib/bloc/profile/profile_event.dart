
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class NameChanged extends ProfileEvent {
  final String name;

  NameChanged({@required this.name});

  @override
  List<Object> get props => [name];
}

class BioChanged extends ProfileEvent {
  final String bio;
  BioChanged({@required this.bio});

  @override
  List<Object> get props => [bio];
}

class PhotoChanged extends ProfileEvent {
  final File photo;

  PhotoChanged({@required this.photo});

  @override
  List<Object> get props => [photo];
}

class AgeChanged extends ProfileEvent {
  final DateTime age;

  AgeChanged({@required this.age});

  @override
  List<Object> get props => [age];
}

class GenderChanged extends ProfileEvent {
  final String gender;

  GenderChanged({@required this.gender});

  @override
  List<Object> get props => [gender];
}

class InterestedInChanged extends ProfileEvent {
  final String interestedIn;

  InterestedInChanged({@required this.interestedIn});

  @override
  List<Object> get props => [interestedIn];
}

class LocationChanged extends ProfileEvent {
  final GeoPoint location;

  LocationChanged({@required this.location});

  @override
  List<Object> get props => [location];
}

class Submitted extends ProfileEvent {
  final String name, bio, gender, interestedIn;
  final DateTime age;
  final GeoPoint location;
  final bool isprivacyChecked;
  final File photo;
  

  Submitted(
      {@required this.name,
      @required this.bio,
      @required this.gender,
      @required this.interestedIn,
      @required this.age,
      @required this.isprivacyChecked,
      @required this.location,
      @required this.photo});

  @override
  List<Object> get props =>
      [location, name, bio, age, gender, isprivacyChecked, interestedIn, photo];
}
