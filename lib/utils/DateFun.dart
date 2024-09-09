

import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class DateFun {


  static getDOBFormat() {
    return "MM/dd/yyyy";
  }

  static getDateUKFormat() {
    return "dd/MM/yyyy";
  }

  static getDateBDFormat() {
    return "dd/MM/yyyy";
  }

  static String getStringFromDateTime(DateTime dt) {
    return DateFormat('dd-MMM-yyyy').format(dt).toString();
  }

  static String getDate(String dt, String format) {
    if (dt.isEmpty) {
      return dt;
    }
    try {
      return Jiffy.parseFromDateTime(DateTime.parse(dt)).format(pattern: format);
    } catch (e) {
      try {
        DateTime d = convertToDateTime(dt, 'mm/dd/yyyy');
        return getStringFromDateTime(d);
      } catch (e) {}
    }
    return dt;
  }
  static DateTime convertToDateTime(String dt, String format) {
    return DateFormat(format).parse(dt);
  }




  static DateTime getDateByFormat(String dt) {
    try {
      return DateFormat("MM-dd-yyyy").parse(dt);
    } catch (_) {
      try {
        return DateFormat("MM/dd/yyyy").parse(dt);
      } catch (_) {
        try {
          return DateFormat("dd-MMM-yyyy").parse(dt);
        } catch (_) {
          try {
            return DateFormat("dd/MMM/yyyy").parse(dt);
          } catch (_) {
            try {
              return DateFormat("dd-MM-yyyy").parse(dt);
            } catch (_) {
              try {
                return DateFormat("dd/MM/yyyy").parse(dt);
              } catch (_) {
                return DateTime.now();
              }
            }
          }
        }
      }
    }
  }
}
