import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrreader/feature/bags/data/model/all_bags_model.dart';
import 'package:qrreader/feature/bags/data/repos/bags_repo.dart';

part 'bags_state.dart';

class BagsCubit extends Cubit<BagsState> {
  BagsCubit(this.bagsRepo) : super(BagsInitial());
  BagsRepo bagsRepo;
  final TextEditingController bagsController = TextEditingController(text: '');
  bool isFiltered = false;

  void increaseBagsCounter() {
    bagsController.text = (int.parse(bagsController.text) + 1).toString();
    emit(IncreaseBagsState());
  }

  void decreaseBagsCounter() {
    if (int.parse(bagsController.text) > 0) {
      bagsController.text = (int.parse(bagsController.text) - 1).toString();
    }
    emit(DecreaseBagsState());
  }

  AllBagsModel allBagsModel = AllBagsModel(message: '', code: 1, data: []);

  Future<void> getAllBags({required String state}) async {
    if (state == 'available') {
      isAvailable = true;
      isUnavailable = false;
    } else if (state == 'unavailable') {
      isAvailable = false;
      isUnavailable = true;
    }
    else{
      isAvailable = false;
      isUnavailable = false;
    }
    emit(GetBagsNumberLoading());
    var result = await bagsRepo.getAllBags(state: state);
    result.fold((l) => emit(GetBagsNumberFailure(error: l.errMessage)), (r) {
      allBagsModel = AllBagsModel.fromJson(r.data);
      if (state == 'all')
        bagsController.text = allBagsModel.data.length.toString();
      emit(GetBagsNumberSuccess(message: allBagsModel.message));
    });
  }

  Future<void> editBagsNumber({required num number}) async {
    emit(EditBagsNumberLoading());
    var result = await bagsRepo.editBagsNumber(number: number);
    result.fold((l) => emit(EditBagsNumberFailure(error: l.errMessage)), (r) {
      emit(EditBagsNumberSuccess(message: r.data['message']));
      getAllBags(state: 'all');
    });
  }

  Future<void> changeBagsState({required num id}) async {
    emit(ChangeBagsStateLoading());
    var result = await bagsRepo.changeBagState(id: id);
    result.fold((l) => emit(ChangeBagsStateFailure(error: l.errMessage)), (r) {
      emit(ChangeBagsStateSuccess(message: r.data['message']));
      getAllBags(state: 'all');
    });
  }

  bool isAvailable = false;
  bool isUnavailable = false;
}
