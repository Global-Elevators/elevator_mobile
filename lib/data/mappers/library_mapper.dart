import 'package:elevator/app/constants.dart';
import 'package:elevator/app/extensions.dart';
import 'package:elevator/data/response/responses.dart';
import 'package:elevator/domain/models/library_model.dart';

// ===============================
// LibraryResponse → LibraryAttachment
// ===============================
extension LibraryResponseMapper on LibraryResponse? {
  LibraryAttachment toDomain() {
    return LibraryAttachment(
      this?.data.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}

// ===============================
// DatumResponse → Datum
// ===============================
extension DatumResponseMapper on DatumResponse? {
  Datum toDomain() {
    return Datum(
      this?.type.orEmpty() ?? Constants.empty,
      this?.typeLabel.orEmpty() ?? Constants.empty,
      this?.attachments.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}

// ===============================
// AttachmentResponse → Attachment
// ===============================
extension AttachmentResponseMapper on AttachmentResponse? {
  Attachment toDomain() {
    return Attachment(
      this?.name.orEmpty() ?? Constants.empty,
      this?.url.orEmpty() ?? Constants.empty,
    );
  }
}

