import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Cubit/AppStates.dart';
import 'package:news_app/local/shared%20preference.dart';
import 'package:news_app/modules/Science/Science.dart';
import 'package:news_app/modules/Settings/Settings.dart';
import 'package:news_app/modules/Sports/sport.dart';
import 'package:news_app/modules/business/business.dart';
import 'package:news_app/network/remote/dio.dart';

class AppCubit extends Cubit<AppState>{
  AppCubit():super (InitialState());
  static AppCubit get(context)=>BlocProvider.of(context);
  int currentState=0;
  List<Widget> Screens=[
    Business(),
    Science(),
    Sports(),
    Settings()
  ];
  List<BottomNavigationBarItem> bottomItems=[
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business'
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science_outlined),
      label: 'Science'
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sport'
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings'
    ),
  ];
  void changeBottomNavBar(index){
    currentState=index;
    emit(AppChangeState());
    if(currentState==1){
      getScience();
    }
    else if(currentState==2){
      getSports();
    }
  }
  List<dynamic> BusinessData=[];
  List<dynamic> SportsData=[];
  List<dynamic> ScienceData=[];
  List<dynamic> searchData=[];
//https://newsapi.org/v2/top-headlines?country=eg&apiKey=3968d4a77b7d46fe886c37c712f75116
  void getBusiness(){
    if (BusinessData.length==0){
      emit(AppBusinessLoadingState());

      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '3968d4a77b7d46fe886c37c712f75116'
      }).then((value) {
        BusinessData = value.data['articles'];
        emit(AppBusinessSuccessState());
      }).catchError((error) {
        emit(AppBusinessErrorState(error: error));
      });
    }
    else{
      emit(AppBusinessSuccessState());
    }
  }
  void getScience(){
  if (ScienceData.length==0) {
      emit(AppScienceLoadingState());

      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': '3968d4a77b7d46fe886c37c712f75116'
      }).then((value) {
        ScienceData = value.data['articles'];
        emit(AppScienceSuccessState());
      }).catchError((error) {
        print('error ${error.toString()}');
        emit(AppScienceErrorState(error: error));
      });
    }
  else{
    emit(AppScienceSuccessState());
  }
  }
  void getSports(){
  if(SportsData.length==0) {
      emit(AppSportsLoadingState());

      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sport',
        'apiKey': '3968d4a77b7d46fe886c37c712f75116'
      }).then((value) {
        SportsData = value.data['articles'];
        emit(AppSportsSuccessState());
      }).catchError((error) {
        print('error ${error.toString()}');
        emit(AppSportsErrorState(error: error));
      });
    }
  else{
    emit(AppSportsSuccessState());
  }
  }
  void getsearch(String value){
  if(SportsData.length==0) {
      emit(AppsearchLoadingState());

      DioHelper.getData(url: 'v2/everything', query: {
        'q': '$value',
        'apiKey': '3968d4a77b7d46fe886c37c712f75116'
      }).then((value) {
        searchData = value.data['articles'];
        emit(AppsearchSuccessState());
      }).catchError((error) {
        print('error ${error.toString()}');
        emit(AppsearchErrorState(error: error));
      });
    }
  else{
    emit(AppsearchSuccessState());
  }
  }
}

class ModeCubit extends Cubit<ModeState>{
  ModeCubit():super(initialModeState());
   bool isDark=true;
  static ModeCubit get(context)=>BlocProvider.of(context);
  void changeFromSherdMode({ required bool fromShared}){
    if(fromShared!=null){
      isDark = fromShared;;
      emit(ChangeModeState());
    }
    else
    {
      isDark = !isDark;
    }
      cachHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(ChangeModeState());
      });

  }
  void changeMode(){
      isDark = !isDark;
      cachHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(ChangeModeState());
      });

  }

}