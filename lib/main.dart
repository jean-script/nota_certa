import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:ml_nota_certa/app/bindings/school_bindings.dart';
import 'package:ml_nota_certa/app/modules/camera/domain/entities/scan_dto.dart';
import 'package:ml_nota_certa/app/modules/school/domain/entities/student_evaluation_answer_hive.dart';
import 'package:ml_nota_certa/app/pages/fata_error_page.dart';
import 'package:ml_nota_certa/app/routes/routes.dart';
import 'package:ml_nota_certa/app/theme/theme.dart';
import 'package:ml_nota_certa/app/utils/app_logger.dart';
import 'package:ml_nota_certa/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    if (Platform.isAndroid || Platform.isIOS) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;

      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);

        return true;
      };
    }

    final dispatcher = WidgetsBinding.instance.platformDispatcher;
    final size = dispatcher.views.first.physicalSize;
    final devicePixelRatio = dispatcher.views.first.devicePixelRatio;

    final logicalWidth = size.width / devicePixelRatio;
    final logicalHeight = size.height / devicePixelRatio;

    final shortestSide = logicalWidth < logicalHeight
        ? logicalWidth
        : logicalHeight;

    final isTablet = shortestSide >= 600;

    if (isTablet) {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        // DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    }

    await Hive.initFlutter();

    Hive.registerAdapter(StudentEvaluationAnswerHiveAdapter());

    await Hive.openBox<StudentEvaluationAnswerHive>('student_answers');

    Hive.registerAdapter(ScanDTOAdapter());

    await Hive.openBox<ScanDTO>('scans');

    Intl.defaultLocale = 'pt_BR';

    await initializeDateFormatting('pt_BR', null);
    runApp(
      DevicePreview(
        enabled: !kReleaseMode && !Platform.isAndroid,
        builder: (context) => MyApp(), // Wrap your app
      ),
    );
  } catch (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    runApp(
      MaterialApp(debugShowCheckedModeBanner: false, home: FataErrorPage()),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      logWriterCallback: logWriter,
      builder: DevicePreview.appBuilder,
      getPages: MyRoutes.get(),
      theme: MyTheme.getTheme(context),
      initialBinding: SchoolBindings(),
    );
  }

  void logWriter(String text, {bool isError = false}) {
    AppLogger.log(text);
  }
}
