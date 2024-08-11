import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:vista/features/host_guest_chat/chat.dart';
import 'package:vista/features/host_guest_chat/inbox.dart';
import 'package:vista/shared/utils/local_storage.dart';

import '../../repository.dart';

part 'add_roster_event.dart';
part 'add_roster_state.dart';

class AddRosterBloc extends Bloc<AddRosterEvent, AddRosterState> {
  final EjabberdApiRepository ejabberdApiRepository;
  AddRosterBloc({required this.ejabberdApiRepository})
      : super(AddRosterInitial()) {
    on<AddRosterEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<AddRoster>((event, emit) async {
      emit(AddRosterLoading());
      try {
        await ejabberdApiRepository.addRoster(
          localuser: event.localuser,
          localhost: event.localhost,
          user: event.user,
          host: event.host,
          nick: event.nick,
        );

        emit(AddRosterSuccess());
        String? v = await LocalStorage.read(key: 'vc');
        Get.to((InboxPage(u: event.localuser, v: v!)));
      } catch (e) {
        emit(AddRosterFailure(e.toString()));
      }
    });
  }
}
