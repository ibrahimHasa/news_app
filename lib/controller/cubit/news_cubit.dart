import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/controller/dio_helper/dio_helper.dart';
import 'package:news/controller/shared_prefernces/shared_prefernces.dart';
import 'package:news/screens/buiness_screen.dart';
import 'package:news/screens/science_screen.dart';
import 'package:news/screens/sports_screen.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'science',
    ),
  ];
  List<Widget> screens = [
    BuinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1) getsports();
    if (index == 2) getScience();

    emit(NewsChangeBottomNavState());
  }

  List<dynamic> business = [];
  void getBusiness() {
    if (business.length == 0) {
      emit(NewsGetBusinessLoadingState());
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'business',
          'apiKey': 'cc54efb64e804b5c8328d0c7be9e5d0b',
        },
      ).then((value) {
        business = value.data['articles'];
        // print(business[0]['title']);
        emit(NewsGetBusinessSuccessState());
      }).catchError((error) {
        print('get business errro ${error.toString()}');
        emit(NewsGetBusinessErrorState(error.toString()));
      });
    } else {
      emit(NewsGetBusinessSuccessState());
    }
  }

  //** */
  List<dynamic> sports = [];
  void getsports() {
    if (sports.length == 0) {
      emit(NewsGetSportsLoadingState());
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': 'cc54efb64e804b5c8328d0c7be9e5d0b',
        },
      ).then((value) {
        sports = value.data['articles'];
        // print(business[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print('get sport errro ${error.toString()}');
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  //** */
  List<dynamic> science = [];
  void getScience() {
    if (science.length == 0) {
      emit(NewsGetScienceLoadingState());
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': 'cc54efb64e804b5c8328d0c7be9e5d0b',
        },
      ).then((value) {
        science = value.data['articles'];
        // print(business[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print('get science errro ${error.toString()}');
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  //** */
  bool isDark = false;
  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(NewsChangeModeState());
    } else
      isDark = !isDark;
    CacheHelper.putData(
      key: 'isDark',
      value: isDark,
    ).then((value) {
      emit(NewsChangeModeState());
    });
    print(isDark);
    emit(NewsChangeModeState());
  }
  //** */

  List<dynamic> search = [];
  void getSearch(value) {
    emit(NewsGetSearchLoadingState());
    search = [];
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': '$value',
        'apiKey': 'cc54efb64e804b5c8328d0c7be9e5d0b',
      },
    ).then((value) {
      search = value.data['articles'];
      // print(business[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print('get Search errro ${error.toString()}');
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }

  //** */
}
