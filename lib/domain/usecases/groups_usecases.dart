import 'package:dartz/dartz.dart';
import 'package:grammar_app/domain/entities/group_entity.dart';
import 'package:grammar_app/domain/failuries/failures.dart';
import 'package:grammar_app/domain/repositories/groups_repository.dart';

class GroupsUseCases {
  final GroupsRepository groupsRepo;
  GroupsUseCases({required this.groupsRepo});

  Either<Failure, List<GroupEntity>> getGroups() {
    return groupsRepo.getGroupsFromDatasource();
    // space for business logic
  }
}
