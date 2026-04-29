import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_devices_state.dart';

class AddDevicesCubit extends Cubit<AddDevicesState> {
  AddDevicesCubit() : super(AddDevicesInitial());
  
}
