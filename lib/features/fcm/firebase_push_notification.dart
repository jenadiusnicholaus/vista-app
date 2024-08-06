import "dart:async";
import "dart:convert";
import "dart:developer";
import "package:firebase_messaging/firebase_messaging.dart";
import "package:flutter_local_notifications/flutter_local_notifications.dart";
import "package:vista/features/fcm/model.dart";
import "package:vista/features/fcm/repository.dart";

import "../../shared/api_call/api.dart";
import "../../shared/environment.dart";

// singleton class to handle all firebase messaging api

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

const String navigationActionId = 'id_3';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
// for handling notifications when the app is in the background
  final StreamController<String?> selectNotificationStream =
      StreamController<String?>.broadcast();

  // android channel
  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.defaultImportance);

  // create flutter local notification plugin instance
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initPushNotification() async {
    // request permission

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    // for notifications when the app is terminated, the app is not running.
    // Is called when the user taps on the notification
    FirebaseMessaging.instance.getInitialMessage().then(handleMassage);
    // for background notifications when the app is terminated, the app is not running.
    // Is called when the user taps on the notification
    FirebaseMessaging.onMessageOpenedApp.listen(handleMassage);
    // for background notifications
    FirebaseMessaging.onMessageOpenedApp.listen(handleBackgroundHandler);
    // for foreground notifications
    FirebaseMessaging.onMessage.listen(handleForegroundNotification);
  }

  Future initLocalNotification() async {
    final iOS = iOSInitializationSettings();
    const android = AndroidInitializationSettings('@mipmap/launcher_icon');
    final settings = InitializationSettings(iOS: iOS, android: android);
    await flutterLocalNotificationsPlugin.initialize(
      settings,
      // For handling notifications when the app is in the background
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            selectNotificationStream.add(notificationResponse.payload);
            var message = RemoteMessage.fromMap(
                jsonDecode(notificationResponse.payload!));
            handleMassage(message);
            break;
          case NotificationResponseType.selectedNotificationAction:
            if (notificationResponse.actionId == navigationActionId) {
              selectNotificationStream.add(notificationResponse.payload);
            }
            break;
        }
      },

      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    final platform =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!;
    await platform.createNotificationChannel(channel);
  }

  // handle foreground notifications
  void handleForegroundNotification(RemoteMessage message) {
    final notification = message.notification;
    final android = message.notification?.android;
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              icon: android.smallIcon,
              channelDescription: channel.description,
              importance: Importance.max,
              priority: Priority.high,
              playSound: true,
              styleInformation: const BigTextStyleInformation(''),
            ),
          ),
          payload: jsonEncode(message.toMap()));
    }
  }

  Future<void> initializeFcmNotifications() async {
    // request permission
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');
    } else {
      log('User declined or has not accepted permission');
    }
    // get the current settings

    // check if expired or is null then get a new token  and save it
    // String token = await LocalStorage.read(key: "fcm_token") ?? "";
    // if (token.isEmpty) {
    //   token = await _firebaseMessaging.getToken() ?? "";
    //   log('token: $token');
    //   await LocalStorage.write(key: "fcm_token", value: token);
    // }

    // String? token = await getToken();

    // handle  notifications when the app is in the  background
    initPushNotification();
  }
}

// handle background notifications
Future<void> handleBackgroundHandler(RemoteMessage? message) async {
  log('Handling a background message ${message?.messageId}');
  log('title: ${message?.notification?.title}');
  log('body: ${message?.notification?.body}');
  log('data: ${message?.data}');
}

void handleMassage(RemoteMessage? message) {
  log('Handling a message ${message?.messageId}');
  log('title: ${message?.notification?.title}');
  log('body: ${message?.notification?.body}');
  log('data: ${message?.data}');
}

iOSInitializationSettings() {
  final StreamController<ReceivedNotification>
      didReceiveLocalNotificationStream =
      StreamController<ReceivedNotification>.broadcast();

  /// Defines a iOS/MacOS notification category for text input actions.
  const String darwinNotificationCategoryText = 'textCategory';

  /// Defines a iOS/MacOS notification category for plain actions.
  const String darwinNotificationCategoryPlain = 'plainCategory';
  final List<DarwinNotificationCategory> darwinNotificationCategories =
      <DarwinNotificationCategory>[
    DarwinNotificationCategory(
      darwinNotificationCategoryText,
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.text(
          'text_1',
          'Action 1',
          buttonTitle: 'Send',
          placeholder: 'Placeholder',
        ),
      ],
    ),
    DarwinNotificationCategory(
      darwinNotificationCategoryPlain,
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.plain('id_1', 'Action 1'),
        DarwinNotificationAction.plain(
          'id_2',
          'Action 2 (destructive)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.destructive,
          },
        ),
        DarwinNotificationAction.plain(
          navigationActionId,
          'Action 3 (foreground)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.foreground,
          },
        ),
        DarwinNotificationAction.plain(
          'id_4',
          'Action 4 (auth required)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.authenticationRequired,
          },
        ),
      ],
      options: <DarwinNotificationCategoryOption>{
        DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
      },
    )
  ];

  /// Note: permissions aren't requested here just to demonstrate that can be
  /// done later
  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
    onDidReceiveLocalNotification:
        (int id, String? title, String? body, String? payload) async {
      didReceiveLocalNotificationStream.add(
        ReceivedNotification(
          id: id,
          title: title,
          body: body,
          payload: payload,
        ),
      );
    },
    notificationCategories: darwinNotificationCategories,
  );

  return initializationSettingsDarwin;
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}

class FcmTokenMenager {
  Future<String?> getToken() async {
    FcmRepository fcmRepository = FcmRepository(
      apiCall: DioApiCall(),
      environment: Environment.instance,
    );
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

    try {
      FcmTokenModel fccToken = await fcmRepository.fetchToken();

      if (fccToken.isStale!) {
        String? token = await firebaseMessaging.getToken();
        await fcmRepository.updateToken(token!);
        return token;
      } else {
        return fccToken.fcmToken;
      }
    } catch (e) {
      // String errorMessage = ExceptionHandler.handleError(e);
      String? token = await firebaseMessaging.getToken();
      await fcmRepository.saveToken(token!);
      return token;
    }
  }
}
