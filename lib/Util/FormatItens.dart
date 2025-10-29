import 'package:intl/intl.dart';

class FormatUtil {
  /// Formata uma string de data enquanto o usuário digita (dd/MM/yyyy).
  static String formatDateInput(String value) {
    String cleanText = value.replaceAll(RegExp(r'\D'), '');

    if (cleanText.length > 2) {
      cleanText = '${cleanText.substring(0, 2)}/${cleanText.substring(2)}';
    }
    if (cleanText.length > 5) {
      cleanText = '${cleanText.substring(0, 5)}/${cleanText.substring(5)}';
    }
    if (cleanText.length > 10) {
      cleanText = cleanText.substring(0, 10);
    }

    return cleanText;
  }

  static String formatDateShort(String dateString) {
    try {
      final inputFormat = DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'", 'en_US');
      final date = inputFormat.parse(dateString, true).toLocal();

      // Retorna apenas dia/mês
      return DateFormat('dd/MM').format(date);
    } catch (e) {
      return '--/--';
    }
  }

  static String formatDuration(int? seconds) {
    if (seconds == null) return '00:00:00';
    final duration = Duration(seconds: seconds);
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final secs = twoDigits(duration.inSeconds.remainder(60));

    return "$hours:$minutes:$secs";
  }

  static String formatTellInput(String value) {
    String cleanText = value.replaceAll(RegExp(r'\D'), '');

    if (cleanText.isNotEmpty) {
      cleanText = '(' + cleanText;
      if (cleanText.length > 3) {
        cleanText = '${cleanText.substring(0, 3)})${cleanText.substring(3)}';
      }
      if (cleanText.length > 9) {
        cleanText = '${cleanText.substring(0, 9)}-${cleanText.substring(9)}';
      }
      if (cleanText.length > 14) {
        // Limita o tamanho máximo a 14 caracteres com o formato completo
        cleanText = cleanText.substring(0, 14);
      }
    }

    return cleanText;
  }

  /// formata o CPF automaticamente enquanto o usuário digita
  static String formatCpfInput(String value) {
    String cleanText = value.replaceAll(RegExp(r'\D'), '');

    if (cleanText.length > 11) {
      cleanText = cleanText.substring(0, 11);
    }

    if (cleanText.length >= 10) {
      return '${cleanText.substring(0, 3)}.${cleanText.substring(3, 6)}.${cleanText.substring(6, 9)}-${cleanText.substring(9)}';
    } else if (cleanText.length >= 7) {
      return '${cleanText.substring(0, 3)}.${cleanText.substring(3, 6)}.${cleanText.substring(6)}';
    } else if (cleanText.length >= 4) {
      return '${cleanText.substring(0, 3)}.${cleanText.substring(3)}';
    } else {
      return cleanText;
    }
  }

  static DateTime parseRfc1123(String rfcString) {
    // Exemplo: "Fri, 16 Jul 2004 00:00:00 GMT"
    final parts = rfcString.split(' ');
    if (parts.length < 6) throw FormatException("Formato RFC inválido");

    final day = int.parse(parts[1]);
    final monthStr = parts[2];
    final year = int.parse(parts[3]);
    final timeParts = parts[4].split(':');
    final hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);
    final second = int.parse(timeParts[2]);

    final months = {
      'Jan': 1,
      'Feb': 2,
      'Mar': 3,
      'Apr': 4,
      'May': 5,
      'Jun': 6,
      'Jul': 7,
      'Aug': 8,
      'Sep': 9,
      'Oct': 10,
      'Nov': 11,
      'Dec': 12
    };

    final month = months[monthStr] ?? (throw FormatException("Mês inválido"));

    return DateTime.utc(year, month, day, hour, minute, second);
  }

  static String toRfc1123FromInput(String input) {
    DateTime dt = DateFormat('dd/MM/yyyy').parse(input);
    final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    final weekday = weekdays[dt.weekday - 1];
    final month = months[dt.month - 1];
    return '$weekday, ${dt.day.toString().padLeft(2, '0')} $month ${dt.year} 00:00:00 GMT';
  }
}
