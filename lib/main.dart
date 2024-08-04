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
import 'package:vista/features/fcm/firebase_push_notification.dart';
import 'package:vista/shared/utils/local_storage.dart';
import 'features/auth/activate_account/bloc/activate_account_bloc.dart';
import 'features/auth/confirm_reset_password/repository.dart';
import 'features/auth/forget_password/bloc/forget_password_bloc.dart';
import 'features/auth/forget_password/repository.dart';
import 'features/auth/phone_number/repository.dart';
import 'features/auth/register/bloc/registration_bloc.dart';
import 'features/auth/register/repository.dart';
import 'features/auth/user_profile/bloc/user_profile_bloc.dart';
import 'features/booking_system/all_booking_requests/bloc/my_booking_request_bloc.dart';
import 'features/booking_system/all_booking_requests/repository.dart';
import 'features/booking_system/bloc/booking_bloc.dart';
import 'features/booking_system/confirm_booking/bloc/confirm_booking_bloc.dart';
import 'features/booking_system/repository.dart';
import 'features/host_guest_chat/connection/bloc/xmppconnection_bloc.dart';
import 'features/location/device_current_location.dart';
import 'features/my_fav_property/bloc/my_fav_properies_bloc.dart';
import 'features/my_fav_property/repository.dart';
import 'features/home_pages/category/bloc/property_category_bloc.dart';
import 'features/home_pages/explore/repository.dart';
import 'features/home_pages/home/home.dart';
import 'features/home_pages/propert_details/bloc/property_details_bloc.dart';
import 'features/home_pages/propert_details/property_reviews/bloc/property_reviews_bloc.dart';
import 'features/home_pages/propert_details/property_reviews/repository.dart';
import 'features/renting_system/bloc/my_renting_bloc.dart';
import 'features/renting_system/confirm_renting/bloc/confirm_renting_bloc.dart';
import 'features/renting_system/repository.dart';
import 'shared/api_call/api.dart';
import 'shared/environment.dart';

import 'shared/token_handler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// ...
// navigation key
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await requestLocationPermission();
  String? token = await LocalStorage.read(key: "access_token");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initializeFcmNotifications();
  await FirebaseApi().initLocalNotification();

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

          // BookingRepository
          RepositoryProvider<GuestBookingRepository>(
              create: (context) => GuestBookingRepository(
                  apiCall: DioApiCall(), environment: Environment.instance)),

          RepositoryProvider<RentingRepository>(
              create: (context) => RentingRepository(
                  apiCall: DioApiCall(), environment: Environment.instance)),
        ],
        child: MultiBlocProvider(
          providers: [
            // Auth blocs
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

            // Home page blocs
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

            // BookingBloc

            BlocProvider<BookingBloc>(
              create: (context) => BookingBloc(
                guestBookingRepository: context.read<GuestBookingRepository>(),
              ),
            ),

            // confirm Booking
            BlocProvider<ConfirmBookingBloc>(
              create: (context) => ConfirmBookingBloc(
                repository: context.read<GuestBookingRepository>(),
              ),
            ),

            // Home page blocs
            BlocProvider<MyRentingBloc>(
                create: (context) => MyRentingBloc(
                      rentingRepository: context.read<RentingRepository>(),
                    )),

            //  confirm renting

            BlocProvider<ConfirmRentingBloc>(
                create: (context) => ConfirmRentingBloc(
                      rentingRepository: context.read<RentingRepository>(),
                    )),

            BlocProvider<MyBookingRequestBloc>(
              create: (context) => MyBookingRequestBloc(
                repository: context.read<GuestBookingRequestsRepository>(),
              ),
            ),

// XmppconnectionBloc
            BlocProvider<XmppconnectionBloc>(
              create: (context) => XmppconnectionBloc(),
            ),
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
