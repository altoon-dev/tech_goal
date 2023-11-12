import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TextInputFormatters {
  static TextInputFormatter dateFormatter(String text) {
    return FilteringTextInputFormatter.allow(
      RegExp(r'^\d{0,2}\.\d{0,2}\.\d{0,4}$'),
    );
  }
}

  var maskFormatter = MaskTextInputFormatter(
      mask: '+7 (###) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  var dateMaskFormatter = MaskTextInputFormatter(
      mask: '##.##.####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

