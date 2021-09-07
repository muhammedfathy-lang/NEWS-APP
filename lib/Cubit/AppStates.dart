abstract class AppState {}
 class InitialState extends AppState {}
 class AppBusinessLoadingState extends AppState {}
 class AppChangeState extends AppState {}
 class AppBusinessSuccessState extends AppState {}
 class AppBusinessErrorState extends AppState {
 var error;
 AppBusinessErrorState({required this.error});}
class AppSportsLoadingState extends AppState {}
class AppSportsState extends AppState {}
class AppSportsSuccessState extends AppState {}
class AppSportsErrorState extends AppState {
 var error;
 AppSportsErrorState({required this.error});}
class AppScienceLoadingState extends AppState {}
class AppScienceState extends AppState {}
class AppScienceSuccessState extends AppState {}
class AppScienceErrorState extends AppState {
 var error;
 AppScienceErrorState({required this.error});}

class AppsearchLoadingState extends AppState {}
class AppsearchState extends AppState {}
class AppsearchSuccessState extends AppState {}
class AppsearchErrorState extends AppState {
 var error;
 AppsearchErrorState({required this.error});}

 abstract class ModeState {}
class initialModeState extends ModeState{}
 class ChangeModeState extends ModeState{}