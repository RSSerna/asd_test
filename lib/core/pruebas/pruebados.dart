import 'package:asd_test/core/pruebas/pruebatres.dart';

class SegundaPrueba {
  TerceraPrueba terceraPrueba = TerceraPrueba();
  String letMeTry(String? msg) {
    try {
      return terceraPrueba.letMeTry(msg);
    } catch (e) {
      throw Exception();
    }
  }
}
