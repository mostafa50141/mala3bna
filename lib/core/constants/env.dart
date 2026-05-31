import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get orsApiKey => dotenv.env['ORS_API_KEY'] ?? '';
}
