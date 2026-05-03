import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_rent/features/admin_add_doctor/data/data_sources/admin_add_doctor_data_source.dart';
import 'package:med_rent/features/admin_add_doctor/data/models/add_doctor_department_model.dart';
import 'package:med_rent/features/admin_add_doctor/data/models/add_doctor_hospital_model.dart';
import 'package:med_rent/features/admin_add_doctor/data/models/add_doctor_model.dart';
import 'add_doctor_state.dart';

class AddDoctorCubit extends Cubit<AddDoctorState> {
  final AdminAddDoctorDataSource _dataSource;

  List<AddDoctorHospitalModel> hospitals = [];
  List<AddDoctorDepartmentModel> departments = [];

  AddDoctorCubit(this._dataSource) : super(AddDoctorInitial());

  Future<void> getHospitals() async {
    emit(AddDoctorLoading());
    try {
      hospitals = await _dataSource.getHospitals();
      emit(HospitalsLoaded(hospitals));
    } catch (e) {
      emit(AddDoctorError(e.toString()));
    }
  }

  Future<void> getDepartments(int hospitalId) async {
    departments = [];
    emit(AddDoctorLoading());
    try {
      departments = await _dataSource.getDepartments(hospitalId);
      emit(DepartmentsLoaded(departments));
    } catch (e) {
      emit(AddDoctorError("Failed to load departments"));
    }
  }

  Future<void> addDoctor(AddDoctorModel doctor) async {
    emit(AddDoctorLoading());
    try {
      final Map<String, dynamic> doctorMap = doctor.toJson();
      if (doctor.image.isNotEmpty && File(doctor.image).existsSync()) {
        doctorMap['Image'] = await MultipartFile.fromFile(
          doctor.image,
          filename: doctor.image.split('/').last,
        );
      }
      final formData = FormData.fromMap(doctorMap);

      final msg = await _dataSource.addDoctor(formData);
      emit(AddDoctorSuccess(msg));
    } catch (e) {
      print("Add Doctor Error: ${e.toString()}");
      emit(AddDoctorError("Failed to add doctor. Check your connection or data."));
    }
  }
}