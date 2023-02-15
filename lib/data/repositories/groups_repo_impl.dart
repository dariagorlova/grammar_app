import 'package:dartz/dartz.dart';
import 'package:grammar_app/data/datasources/groups_local_datasource.dart';
import 'package:grammar_app/data/exceptions/exceptions.dart';
import 'package:grammar_app/domain/entities/group_entity.dart';
import 'package:grammar_app/domain/repositories/groups_repository.dart';

import '../../domain/failuries/failures.dart';

class GroupsRepoImpl implements GroupsRepository {
  final GroupsLocalDatasource groupsLocalDatasource;
  GroupsRepoImpl({required this.groupsLocalDatasource});

  @override
  Either<Failure, List<GroupEntity>> getGroupsFromDatasource() {
    try {
      final result = groupsLocalDatasource.getGroupsFromRepo();
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      return left(GeneralFailure());
    }
  }
}
