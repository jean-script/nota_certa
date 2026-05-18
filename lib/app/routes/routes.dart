// ignore_for_file: constant_identifier_names

import 'package:get/route_manager.dart';
import 'package:ml_nota_certa/app/bindings/dashboard_bindings.dart';
import 'package:ml_nota_certa/app/bindings/evalution_bindings.dart';
import 'package:ml_nota_certa/app/pages/classes_page.dart';
import 'package:ml_nota_certa/app/pages/dashboard_page.dart';
import 'package:ml_nota_certa/app/pages/home_page.dart';
import 'package:ml_nota_certa/app/pages/register_response_page.dart';
import 'package:ml_nota_certa/app/pages/review_detail_page.dart';
import 'package:ml_nota_certa/app/pages/review_page.dart';

class MyRoutes {
  static const String HOME = '/';
  static const String CLASSES = '/classes';
  static const String REVIEW = '/review';
  static const String REVIEW_DETAIL = '/review/detail';
  static const String REGISTER_RESPONSE = '/create/response';
  static const String DASHBOARD = '/dashboard';

  static List<GetPage> get() {
    return [
      GetPage(name: HOME, page: () => HomePage()),

      GetPage(name: CLASSES, page: () => ClassesPage()),
      GetPage(name: REVIEW, page: () => ReviewPage()),
      GetPage(name: REVIEW_DETAIL, page: () => ReviewDetailPage()),
      GetPage(
        name: REGISTER_RESPONSE,
        page: () => RegisterResponseStudentPage(),
        binding: EvalutionBindings(),
      ),
      GetPage(
        name: DASHBOARD,
        page: () => DashboardPage(),
        bindings: [EvalutionBindings(), DashboardBindings()],
      ),
    ];
  }
}
