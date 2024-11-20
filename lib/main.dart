import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; 
import 'package:skb_cwd_app/Features/UserFeatures/auth/data/repository/auth_repo.dart';
import 'package:skb_cwd_app/Features/UserFeatures/auth/presentation/bloc/cubit/auth_cubit.dart';
import 'Features/AdminFeatures/admin_dashboard/data/remote/admin_repo.dart';
import 'Features/AdminFeatures/admin_dashboard/presentation/bloc/cubit/admin_cubit.dart';
import 'Features/UserFeatures/home/data/remote/home_repo.dart';
import 'Features/UserFeatures/home/presentation/cubit/home_cubit.dart';
import 'config/page route/page_route.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
///main app entry 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Portal(
      ///initialize state management bloc
      child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => HomeCubit(HomeRepo())),
            BlocProvider(create: (context) => AuthCubit(AuthRepo())),
            BlocProvider(create: (context) => AdminCubit(AdminRepo())),
          ],
          ////iniatialize screenutil for screen reponsivness
          child: ScreenUtilInit(
              minTextAdapt: true,
              splitScreenMode: true,
              designSize: MediaQuery.sizeOf(context),
              builder: (context, child) {
                return MaterialApp(
                    builder: (context, child) {
                      return MediaQuery(
                          data: MediaQuery.of(context).copyWith(
                              textScaler: const TextScaler.linear(0.9)),
                          child: child!);
                    },
                    debugShowCheckedModeBanner: false,
                    title: 'skwb',
                    theme: ThemeData(
                        colorScheme:
                            ColorScheme.fromSeed(seedColor: Colors.white),
                        useMaterial3: true),
                      ///navigation
                    initialRoute: RouteName.login,
                    onGenerateRoute: AppRoute.onGeneratedRoute,
                    navigatorKey: navigatorKey);
              })),
    );
  }
}
