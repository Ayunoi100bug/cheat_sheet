import 'package:bcrypt/bcrypt.dart';

Future<String> hashPassword(String password) async {
  var passwordSalt = await BCrypt.gensalt();
  return await BCrypt.hashpw(password, passwordSalt);
}