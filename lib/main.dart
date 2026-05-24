import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:wassl/core/bridge/bloc_to_getx_sync.dart';
import 'package:wassl/core/di/injection_container.dart' as di;
import 'package:wassl/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:wassl/features/attendance/presentation/cubit/attendance_cubit.dart';
import 'package:wassl/features/finance/presentation/cubit/finance_cubit.dart';
import 'package:wassl/features/home/presentation/cubit/home_cubit.dart';
import 'package:wassl/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:wassl/features/vacations/presentation/cubit/vacations_cubit.dart';
import 'package:wassl/getx_controllers/app_controller.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/views/pages/intro/splash_screen.dart';

import 'helpers/translation/local_strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.initDependencies(useMocks: true);

  AppController appController = Get.put(AppController());

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  tz.initializeTimeZones();

  await appController.getLanguage();

  await initializeDateFormatting();

  appController.deployingForApple = true;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    appController.testingUserName = 'test2@waslhr.com';

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (_) => di.sl<AuthCubit>()),
        BlocProvider<OrdersCubit>(create: (_) => di.sl<OrdersCubit>()),
        BlocProvider<AttendanceCubit>(create: (_) => di.sl<AttendanceCubit>()),
        BlocProvider<HomeCubit>(create: (_) => di.sl<HomeCubit>()),
        BlocProvider<FinanceCubit>(create: (_) => di.sl<FinanceCubit>()),
        BlocProvider<VacationsCubit>(create: (_) => di.sl<VacationsCubit>()),
      ],
      child: BlocToGetxSync(
        child: GetMaterialApp(
          title: 'Wasl',
          translations: LocalString(),
          locale: Locale(appController.langs[0], appController.langs[1]),
          localizationsDelegates: const [
            MonthYearPickerLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: AppColors.materialOrangeColor,
            fontFamily: 'AraHamah',
          ),
          home: const SplashScreen()),
        ),
      );
  }
}
