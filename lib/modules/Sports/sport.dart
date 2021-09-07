import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Cubit/AppCubit.dart';
import 'package:news_app/Cubit/AppStates.dart';
import 'package:news_app/components/components.dart';

class Sports extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
      listener: (context,state){},
      builder: (context,state){
        var List =AppCubit.get(context).SportsData;
        if (state is! AppSportsLoadingState){
          return ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder:(context,index)=>BuildArticlesItem(List[index],context),
              separatorBuilder: (context,index)=>Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey,
                ),
              ),
              itemCount: List.length)
          ;
        }
        else
          return Center(child: CircularProgressIndicator());
      },

    );
  }
}
