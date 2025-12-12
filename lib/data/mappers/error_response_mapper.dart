import 'package:elevator/app/constants.dart';

extension ErrorResponseMapper on Map<String, dynamic>? {
  String toDomain() {
    if (this == null) return Constants.empty;

    // Check if there's an errors object with validation messages
    final errors = this!['errors'];
    if (errors is Map<String, dynamic> && errors.isNotEmpty) {
      // Get the first error field (phone, email, etc.)
      final firstErrorField = errors.values.first;

      // Extract the first error message from the array
      if (firstErrorField is List && firstErrorField.isNotEmpty) {
        return firstErrorField.first.toString();
      }
    }

    // Fallback to the message field
    return this!['message']?.toString() ?? Constants.empty;
  }
}

final data = null;

// Step 1: Check if data is null
// if (this == null) return Constants.empty; // ✅ Yes!
// // Returns: "" (empty string)
// ```

// **Result:** `""` (empty string)

// ---

// ## **Visual Summary**
// ```
// API Response
//      ↓
// ┌─────────────────────┐
// │ Is data null?       │
// └────────┬────────────┘
//          │
//     ┌────┴────┐
//    YES       NO
//     │         │
//     ↓         ↓
//  Return ""  Extract errors object
//             │
//             ↓
//    ┌────────────────────┐
//    │ Is errors NOT empty?│
//    └────────┬───────────┘
//             │
//        ┌────┴────┐
//       YES       NO
//        │         │
//        ↓         ↓
//    Get first  Return message
//    error msg   field value
//        │         │
//        ↓         ↓
//    "The email  "Invalid
//     field is    credentials"
//     required"
