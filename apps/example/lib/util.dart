import 'dart:convert';
import 'dart:html';

Map<String, dynamic>? getMiddlewareData() {
  var middlewareData = querySelector('#__FSM_DATA__')?.text;
  if (middlewareData == null) {
    return null;
  }
  return jsonDecode(middlewareData);
}
