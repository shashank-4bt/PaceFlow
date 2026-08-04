import 'package:logging/logging.dart';

/// Structured application logger built on `package:logging`.
final class AppLogger {
  AppLogger(String name) : _logger = Logger(name);

  final Logger _logger;

  static void configure({Level level = Level.INFO}) {
    Logger.root.level = level;
    Logger.root.onRecord.listen((record) {
      final buffer = StringBuffer()
        ..write('[${record.level.name}] ${record.loggerName}: ${record.message}');
      if (record.error != null) {
        buffer.write(' | error: ${record.error}');
      }
      // ignore: avoid_print
      print(buffer.toString());
      if (record.stackTrace != null) {
        // ignore: avoid_print
        print(record.stackTrace);
      }
    });
  }

  void fine(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.fine(message, error, stackTrace);
  }

  void info(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.info(message, error, stackTrace);
  }

  void warning(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.warning(message, error, stackTrace);
  }

  void error(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.severe(message, error, stackTrace);
  }
}
