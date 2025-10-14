import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:elevator/data/network/failure.dart';
import 'package:elevator/domain/models/upload_media_model.dart';
import 'package:elevator/domain/repository/repository.dart';
import 'package:elevator/domain/usecase/base_usecase.dart';

class UploadedMediaUseCase implements BaseUseCase<List<MultipartFile>, UploadMediaModel> {
  final Repository _repository;
  UploadedMediaUseCase(this._repository);

  @override
  Future<Either<Failure, UploadMediaModel>> execute(
    List<MultipartFile> input,
  ) async {
    return await _repository.uploadMedia(input);
  }
}