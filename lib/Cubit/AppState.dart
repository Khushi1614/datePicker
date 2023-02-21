abstract class AppState
{}
class InitialState extends AppState{}
class LoadingState extends AppState{}
class LoadedState extends AppState{}
class DateSelectedState extends AppState{
  final  datePicked;
  DateSelectedState(this.datePicked);
}
