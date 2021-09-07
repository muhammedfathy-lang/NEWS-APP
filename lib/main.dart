
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/Cubit/AppCubit.dart';
import 'package:news_app/Cubit/AppStates.dart';
import 'package:news_app/local/shared%20preference.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/network/remote/dio.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await cachHelper.init();
  bool? isDark=cachHelper.getData(key: 'isDark');
  runApp(NewsApp(isDark!));
}
class NewsApp extends StatelessWidget{
  final bool isDark;
  NewsApp(this.isDark);
  @override
  Widget build(BuildContext context) {
   return MultiBlocProvider(providers: [
     BlocProvider(create: (BuildContext context)=>ModeCubit()..changeFromSherdMode(fromShared: isDark),),
    BlocProvider(create: (BuildContext context) =>AppCubit()..getBusiness(),)
   ], child:
     BlocConsumer<ModeCubit,ModeState>(
       listener: ( context, state) {  },
       builder: ( context,  state)=> MaterialApp(
         theme: ThemeData(
           primarySwatch:Colors.deepOrange ,
           floatingActionButtonTheme: FloatingActionButtonThemeData(
             backgroundColor: Colors.deepOrange,
           ),
           appBarTheme: AppBarTheme(
             titleSpacing: 20.0,
               iconTheme: IconThemeData(
                 color: Colors.black,
               ),
               titleTextStyle: TextStyle(
                   color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25
               ),
               backgroundColor: Colors.white,
               elevation: 0.0,
               backwardsCompatibility: false,
               systemOverlayStyle: SystemUiOverlayStyle(
                 statusBarIconBrightness:Brightness.dark,
                 statusBarColor:Colors.white,

               )
           ),
           scaffoldBackgroundColor: Colors.white,
           bottomNavigationBarTheme: BottomNavigationBarThemeData(
               type: BottomNavigationBarType.fixed,
               selectedItemColor: Colors.orangeAccent,
               elevation: 40.0,
               backgroundColor: Colors.white
           ),
           textTheme: TextTheme(
               bodyText1:TextStyle(
                 fontSize: 18.0,fontWeight: FontWeight.w600,
                 color: Colors.black,
               )
           ),
         ),
         darkTheme: ThemeData(
             primarySwatch:Colors.deepOrange ,
             floatingActionButtonTheme: FloatingActionButtonThemeData(
               backgroundColor: Colors.deepOrange,
             ),
             appBarTheme: AppBarTheme(
                 titleSpacing: 20.0,
                 iconTheme: IconThemeData(
                   color: Colors.white,
                 ),
                 titleTextStyle: TextStyle(
                     color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25
                 ),
                 backgroundColor:HexColor('333739'),
                 elevation: 0.0,
                 backwardsCompatibility: false,
                 systemOverlayStyle: SystemUiOverlayStyle(
                   statusBarColor: HexColor('333739'),
                   statusBarIconBrightness:Brightness.light,
                 )
             ),
             scaffoldBackgroundColor: HexColor('333739'),
             bottomNavigationBarTheme: BottomNavigationBarThemeData(
                 type: BottomNavigationBarType.fixed,
                 backgroundColor: HexColor('333739'),
                 unselectedItemColor: Colors.grey,
                 selectedItemColor: Colors.orangeAccent,
                 elevation: 40.0
             ),
             textTheme: TextTheme(
                 bodyText1:TextStyle(
                   fontSize: 18.0,fontWeight: FontWeight.w600,
                   color: Colors.white,
                 )
             )
         ),
        themeMode: ModeCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,

         home: BlocConsumer<AppCubit,AppState>(
           listener: (BuildContext context, state) {  },
           builder: (BuildContext context, Object? state) {
             var cubit=AppCubit.get(context);
             return Scaffold(
               appBar: AppBar(
                 actions: [
                   IconButton(onPressed: (){
                     Navigator.push(context,
                     MaterialPageRoute(builder:(context)=> searchScreen())
                     );
                   },
                     icon: Icon(Icons.search),iconSize: 30.0,),
                   IconButton(onPressed: (){
                     ModeCubit.get(context).changeMode();
                   },
                     icon: Icon(Icons.brightness_6_outlined),iconSize: 30.0,),
                 ],
                 title: Container(
                   child: Row(
                     children: [
                       Column(
                         children: [
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Center(child: Text('NEWS App')),
                           ),
                         ],
                       ),
                     ],
                   ),
                 ),
               ),
               bottomNavigationBar: BottomNavigationBar(
                 currentIndex: cubit.currentState,
                 onTap: (index){
                   cubit.changeBottomNavBar(index);
                 }
                 , items: cubit.bottomItems,
               ),
               body: cubit.Screens[cubit.currentState],
             );
           },
         ),
       ),

     ));
  }

}