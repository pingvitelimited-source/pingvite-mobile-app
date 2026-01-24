import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/routes.dart';
import 'package:pingvite/core/theme/app_theme.dart';
import 'package:pingvite/core/theme/theme_controller.dart';
import 'package:pingvite/core/utils/session_manager.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/features/home/presentation/pages/home_page.dart';
import 'package:pingvite/features/inital_screen/presentation/pages/initial_page.dart';
import 'package:pingvite/features/location_search/presentation/bloc/location_search_bloc.dart';
import 'package:pingvite/features/location_selection/presentation/bloc/location_bloc.dart';
import 'package:pingvite/service_locator_dependencies.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependecies();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? _isLoggedIn;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final isLoggedIn = await SessionManager.isLoggedIn();
    setState(() {
      _isLoggedIn = isLoggedIn;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    sl<SizeConfig>().init(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeController(),
      child: Consumer<ThemeController>(
        builder: (context, themeController, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => sl<LocationBloc>()),
              BlocProvider(create: (context) => sl<LocationSearchBloc>()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: Constants.appTitle,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeController.themeMode,
              onGenerateRoute: AppRoutes.generateRoute,
              home: _buildHome(themeController),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHome(ThemeController themeController) {
    // Show empty scaffold while loading (native splash still visible)
    if (!themeController.isInitialized || _isLoggedIn == null) {
      return const Scaffold(body: SizedBox.shrink());
    }

    return _isLoggedIn! ? const HomePage() : InitialPage();
  }
}
