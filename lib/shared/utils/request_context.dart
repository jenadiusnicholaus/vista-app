import 'package:get/get.dart';

import '../../constants/consts.dart';
import '../../features/booking_system/booking_page.dart';
import '../../features/buying_system/buying_page.dart';
import '../../features/renting_system/renting_page.dart';

getTheRequestContext(event) {
  switch (event.requestContext) {
    case RequestContext.booking:
      Get.off(() => BookingPage(property: event.property));
      break;
    case RequestContext.renting:
      Get.off(() => RentingPage(property: event.property));
      break;
    case RequestContext.buying:
      Get.off(() => BuyPropertyPage(property: event.property));
      break;
  }
}
