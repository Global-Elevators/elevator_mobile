import 'package:elevator/domain/models/base__model.dart';

class LibraryAttachment extends BaseModel {
  List<Datum>? data;

  LibraryAttachment(this.data);
}

class Datum {
  String type;
  String typeLabel;
  List<Attachment> attachments;

  Datum(this.type, this.typeLabel, this.attachments);
}

class Attachment {
  String name;
  String url;

  Attachment(this.name, this.url);
}
