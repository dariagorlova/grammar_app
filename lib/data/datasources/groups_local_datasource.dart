import 'package:flutter/material.dart';
import 'package:grammar_app/domain/entities/group_entity.dart';

abstract class GroupsLocalDatasource {
  List<GroupEntity> getGroupsFromRepo();
}

class GroupsLocalDatasourceImpl implements GroupsLocalDatasource {
  GroupsLocalDatasourceImpl();

  @override
  List<GroupEntity> getGroupsFromRepo() {
    return const [
      GroupEntity(
        title: 'Past',
        id: 0,
        description: 'Поговоримо про минуле',
        colorBackground: Colors.red,
      ),
      GroupEntity(
        title: 'Present',
        id: 1,
        description: 'Поговоримо про теперешнє',
        colorBackground: Colors.yellow,
      ),
      GroupEntity(
        title: 'Future',
        id: 2,
        description: 'Поговоримо про майбутнє',
        colorBackground: Colors.green,
      ),
      GroupEntity(
        title: 'Conditionals',
        id: 3,
        description: 'Умовні речення',
        colorBackground: Colors.blue,
      ),
    ];
  }
}
