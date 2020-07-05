import 'package:flutter_dotenv/flutter_dotenv.dart';

class Url {
  static String apiBaseUrl = DotEnv().env['HOST'];
}
