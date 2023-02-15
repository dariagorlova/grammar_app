import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class GroupEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final Color colorBackground;

  const GroupEntity({
    required this.title,
    required this.id,
    required this.description,
    required this.colorBackground,
  });

  @override
  List<Object?> get props => [title, id, description, colorBackground];
}
