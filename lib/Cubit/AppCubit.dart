import 'package:datepicker/Cubit/AppState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(InitialState()) {

emit(LoadingState());
  }
  selected(){
    emit(LoadedState());
  }
  getDate(var datePicked)
  {
    emit(DateSelectedState(datePicked));
  }


}
