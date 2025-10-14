import 'package:elevator/data/response/responses.dart';
import 'package:elevator/domain/models/upload_media_model.dart';

extension UploadMediaMapper on UploadMediaResponse? {
  UploadMediaModel toDomain() {
    List<UploadedInfoMediaModel> uploads = [];
    if (this != null && this!.data != null && this!.data!.uploads != null) {
      uploads = this!.data!.uploads!.map(
            (upload) =>
                UploadedInfoMediaModel(upload.id ?? '', upload.url ?? ''),
          )
          .toList();
    }
    return UploadMediaModel(UploadedMediaDataModel(uploads));
  }
}
