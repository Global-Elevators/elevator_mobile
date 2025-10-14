class UploadedInfoMediaModel {
  final String id;
  final String url;

  UploadedInfoMediaModel(this.id, this.url);
}

class UploadedMediaDataModel {
  final List<UploadedInfoMediaModel> uploads;

  UploadedMediaDataModel(this.uploads);
}

class UploadMediaModel {
  final UploadedMediaDataModel data;

  UploadMediaModel(this.data);
}
