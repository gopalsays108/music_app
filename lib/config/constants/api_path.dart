import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class ApiPath{
    static String BASE_URL = "${dotenv.env['BASE_URL']}";
}