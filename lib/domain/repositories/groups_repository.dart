import 'package:dartz/dartz.dart';
import 'package:grammar_app/domain/entities/group_entity.dart';
import 'package:grammar_app/domain/failuries/failures.dart';

abstract class GroupsRepository {
  Either<Failure, List<GroupEntity>> getGroupsFromDatasource();
}
