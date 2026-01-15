//import 'package:flutter_application_1/features/auth/ui/login_page.dart';
import 'package:flutter_application_1/features/auth/ui/loginpage.dart';
import 'package:flutter_application_1/features/shell/ui/main_shell.dart';

class AppRoutes {
  static const login = '/login';
  static const shell = '/shell';

  static final routes = {
    login: (_) => LoginPage(),
    shell: (_) => MainShell(),
  };
}