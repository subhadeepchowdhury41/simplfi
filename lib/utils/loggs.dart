import 'dart:developer' as developer;

void logWithColor({
  String? message,
  String? color
}) {
  final colorMap = {
    'reset':   '\x1B[0m',
    'black':   '\x1B[30m',
    'white':   '\x1B[37m',
    'red':     '\x1B[31m',
    'green':   '\x1B[32m',
    'yellow':  '\x1B[33m',
    'blue':    '\x1B[34m',
    'cyan':    '\x1B[36m'
  };
  developer.log('${colorMap[color ?? 'yellow']}$message${colorMap['reset']}');
}