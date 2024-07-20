import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vista/features/auth/activate_account/repository.dart';
import 'package:vista/features/auth/confirm_reset_password/bloc/confirm_reset_password_bloc.dart';
import 'package:vista/features/auth/email_login/bloc/email_login_bloc.dart';
import 'package:vista/features/auth/email_login/repository.dart';
import 'package:vista/features/auth/phone_number/bloc/phone_number_auth_bloc.dart';
import 'package:vista/features/auth/user_profile/repository.dart';
import 'package:vista/features/home_pages/propert_details/repository.dart';
import 'package:vista/shared/Theme/theming.dart';
import 'package:vista/features/auth/email_login/email_login.dart';
import 'package:vista/features/search/search_property.dart';
import 'package:vista/features/search/searched_result_page.dart';
import 'package:vista/shared/utils/local_storage.dart';
import 'features/auth/activate_account/bloc/activate_account_bloc.dart';
import 'features/auth/confirm_reset_password/repository.dart';
import 'features/auth/forget_password/bloc/forget_password_bloc.dart';
import 'features/auth/forget_password/repository.dart';
import 'features/auth/phone_number/repository.dart';
import 'features/auth/register/bloc/registration_bloc.dart';
import 'features/auth/register/repository.dart';
import 'features/auth/user_profile/bloc/user_profile_bloc.dart';
import 'features/location/device_current_location.dart';
import 'features/my_fav_property/bloc/my_fav_properies_bloc.dart';
import 'features/my_fav_property/repository.dart';
import 'features/home_pages/category/bloc/property_category_bloc.dart';
import 'features/home_pages/explore/repository.dart';
import 'features/home_pages/home/home.dart';
import 'features/home_pages/propert_details/bloc/property_details_bloc.dart';
import 'features/home_pages/propert_details/property_reviews/bloc/property_reviews_bloc.dart';
import 'features/home_pages/propert_details/property_reviews/repository.dart';
import 'shared/api_call/api.dart';
import 'shared/environment.dart';

import 'shared/token_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await requestLocationPermission();
  String? token = await LocalStorage.read(key: "access_token");

  if (token == null) {
    runApp(const MyApp(isTokenExpired: true));
    return;
  }
  bool isTokenExpired = TokenHandler.isExpired(token);
  runApp(MyApp(isTokenExpired: isTokenExpired));
}

class MyApp extends StatefulWidget {
  final bool isTokenExpired;

  const MyApp({super.key, required this.isTokenExpired});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkModeEnabled = false;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<PhoneNumberRepository>(
              create: (context) => PhoneNumberRepository(
                  apiCall: DioApiCall(), environment: Environment.instance)),
          RepositoryProvider<RegistrationRepository>(
              create: (context) => RegistrationRepository(
                  apiCall: DioApiCall(), environment: Environment.instance)),
          RepositoryProvider<ActivateAccountRepository>(
              create: (context) => ActivateAccountRepository(
                  apiCall: DioApiCall(), environment: Environment.instance)),
          RepositoryProvider<EmailLoginRepository>(
              create: (context) => EmailLoginRepository(
                  apiCall: DioApiCall(), environment: Environment.instance)),
          RepositoryProvider<ForgetPasswordRepository>(
              create: (context) => ForgetPasswordRepository(
                  apiCall: DioApiCall(), environment: Environment.instance)),
          RepositoryProvider<ConfirmResetPasswordRepository>(
              create: (context) => ConfirmResetPasswordRepository(
                  apiCall: DioApiCall(), environment: Environment.instance)),
          RepositoryProvider<UserProfileRepository>(
              create: (context) => UserProfileRepository(
                  apiCall: DioApiCall(), environment: Environment.instance)),
          RepositoryProvider<ProperDetailsRepository>(
              create: (context) => ProperDetailsRepository(
                  apiCall: DioApiCall(), environment: Environment.instance)),
          RepositoryProvider<PropertyRepository>(
              create: (context) => PropertyRepository(
                  apiCall: DioApiCall(), environment: Environment.instance)),
          RepositoryProvider<MyFavoritePropertyRepository>(
              create: (context) => MyFavoritePropertyRepository(
                  apiCall: DioApiCall(), environment: Environment.instance)),
          RepositoryProvider<PropertyReviewsRepository>(
              create: (context) => PropertyReviewsRepository(
                  apiCall: DioApiCall(), environment: Environment.instance)),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<PhoneNumberAuthBloc>(
                create: (context) => PhoneNumberAuthBloc(
                    phoneNumberRepository:
                        context.read<PhoneNumberRepository>())),
            BlocProvider<RegistrationBloc>(
                create: (context) => RegistrationBloc(
                    registrationRepository:
                        context.read<RegistrationRepository>())),
            BlocProvider<ActivateAccountBloc>(
                create: (context) => ActivateAccountBloc(
                    activateAccountRepository:
                        context.read<ActivateAccountRepository>())),
            BlocProvider<EmailLoginBloc>(
                create: (context) => EmailLoginBloc(
                    emailLoginRepository:
                        context.read<EmailLoginRepository>())),
            BlocProvider<ForgetPasswordBloc>(
                create: (context) => ForgetPasswordBloc(
                    forgetPasswordRepository:
                        context.read<ForgetPasswordRepository>())),
            BlocProvider<ConfirmResetPasswordBloc>(
                create: (context) => ConfirmResetPasswordBloc(
                    confirmResetPasswordRepository:
                        context.read<ConfirmResetPasswordRepository>())),
            BlocProvider<UserProfileBloc>(
                create: (context) => UserProfileBloc(
                    userProfileRepository:
                        context.read<UserProfileRepository>())),
            BlocProvider<PropertyDetailsBloc>(
                create: (context) => PropertyDetailsBloc(
                    properDetailsRepository:
                        context.read<ProperDetailsRepository>())),
            BlocProvider<PropertyCategoryBloc>(
                create: (context) => PropertyCategoryBloc(
                    properDetailsRepository:
                        context.read<PropertyRepository>())),
            BlocProvider<MyFavProperiesBloc>(
                create: (context) => MyFavProperiesBloc(
                    myFavoritePropertyRepository:
                        context.read<MyFavoritePropertyRepository>())),
            BlocProvider<PropertyReviewsBloc>(
                create: (context) => PropertyReviewsBloc(
                    propertyReviewsRepository:
                        context.read<PropertyReviewsRepository>())),
          ],
          child: ScreenUtilInit(
              designSize: const Size(360, 690),
              builder: (BuildContext context, Widget? child) {
                return GetMaterialApp(
                  supportedLocales: const <Locale>[
                    Locale('en', ''),
                    Locale('ar', ''),
                  ],
                  routes: {
                    '/login': (context) => const EmailLogin(),
                    '/home': (context) => const HomePage(),
                    '/search': (context) => const SearchProperty(),
                  },
                  debugShowCheckedModeBanner: false,
                  home: const HomePage(),
                  theme: CustomTheme.lightTheme,
                  darkTheme: CustomTheme.darkTheme,
                  themeMode:
                      isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
                );
              }),
        ),
      ),
    );
  }
}
