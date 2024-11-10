import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrreader/feature/home_page/data/model/all_unverified_model.dart';
import 'package:qrreader/feature/messages/data/model/all_registers_model.dart';
import '../../data/model/all_messages_model.dart';
import '../../data/repos/messages_repo.dart';

part 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit(this.messagesRepo) : super(MessagesInitial());
  MessagesRepo messagesRepo;
  AllRegistersModel allRegistersModel=AllRegistersModel(code: 1, message: 'message', data: []);
  AllMessageModel allMessagesModel = AllMessageModel(code: 1, message: 'message', data: []);

  Future<void> getAllMessages()async{
        emit(GetMessagesLoading());
        var result = await messagesRepo.getAllMessages();
        result.fold((failure) {
          emit(GetMessagesFailure(error: failure.errMessage));
        }, (r) {
          allMessagesModel = AllMessageModel.fromJson(r.data);
          emit(GetMessagesSuccess(message: allMessagesModel.message));
        });
  }

  AllUnverifiedModel allUnverifiedModel = AllUnverifiedModel(code: 1, message: 'message', data: []);

  Future<void> getAllUnverified()async{
        emit(GetUnverifiedLoading());
        var result = await messagesRepo.getAllUnverified();
        result.fold((failure) {
          emit(GetUnverifiedFailure(error: failure.errMessage));
        }, (r) {
          allUnverifiedModel = AllUnverifiedModel.fromJson(r.data);
          emit(GetUnverifiedSuccess(message: allMessagesModel.message));
        });
  }

  Future<void> getAllRegisters()async{
        emit(GetRegistersLoading());
        var result = await messagesRepo.getAllRegisters();
        result.fold((failure) {
          emit(GetRegistersFailure(error: failure.errMessage));
        }, (r) {
          allRegistersModel = AllRegistersModel.fromJson(r.data);
          emit(GetRegistersSuccess(message: allMessagesModel.message));
        });
  }

  Future<void> acceptUser({required num id})async{
        emit(AcceptUserLoading());
        var result = await messagesRepo.acceptUser(id: id);
        result.fold((failure) {
          emit(AcceptUserFailure(error: failure.errMessage));
        }, (r) {
          emit(AcceptUserSuccess(message: r.data['message']));
        getAllUnverified();
        });
  }
  Future<void> rejectUser({required num id})async{
        emit(RejectUserLoading());
        var result = await messagesRepo.rejectUser(id: id);
        result.fold((failure) {
          emit(RejectUserFailure(error: failure.errMessage));
        }, (r) {
          emit(RejectUserSuccess(message: r.data['message']));
          getAllUnverified();
        });
  }

}
