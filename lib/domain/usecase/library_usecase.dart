import 'package:dartz/dartz.dart';
import 'package:elevator/data/network/failure.dart';
import 'package:elevator/domain/models/library_model.dart';
import 'package:elevator/domain/repository/repository.dart';
import 'package:elevator/domain/usecase/base_usecase.dart';

class LibraryUsecase extends BaseUseCase<void, LibraryAttachment> {
  final Repository _repository;

  LibraryUsecase(this._repository);

  @override
  Future<Either<Failure, LibraryAttachment>> execute(void input) async {
    return await _repository.getLibrary();
  }
}
