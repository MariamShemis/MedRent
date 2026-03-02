import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_rent/features/contact_us/data/data_sources/contact_us_data_source.dart';
import 'package:med_rent/features/contact_us/data/models/contact_us_model.dart';
import 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  final ContactUsDataSource remoteDataSource;

  ContactUsCubit(this.remoteDataSource)
      : super(ContactUsInitial());

  Future<void> sendContactMessage({
    required String name,
    required String email,
    required String subject,
    required String body,
  }) async {
    emit(ContactUsLoading());

    try {
      final model = ContactUsModel(
        name: name,
        email: email,
        subject: subject,
        body: body,
      );

      final result = await remoteDataSource.sendMessage(model);

      emit(ContactUsSuccess(result));
    } catch (e) {
      emit(ContactUsError(e.toString()));
    }
  }
}