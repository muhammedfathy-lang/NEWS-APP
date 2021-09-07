import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Cubit/AppCubit.dart';
import 'package:news_app/Cubit/AppStates.dart';
import 'package:news_app/components/components.dart';

class searchScreen extends StatelessWidget {
late TextEditingController searchcontroller;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
      listener: (context,state){},
      builder: ( context,  state)
      {
        var list=AppCubit.get(context).searchData;
        return  Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'pleas enter search word';
                  }
                  else
                    return null;
                },
                onTap: () {
                  searchcontroller = TextEditingController();
                },
                onChanged: (value) {
                  AppCubit.get(context).getsearch(value);
                },
                keyboardType: TextInputType.text,

              ),
            ),
             Expanded(child: ListView.separated(
                 physics: BouncingScrollPhysics(),
                 itemBuilder:(context,index)=>BuildArticlesItem(list[index],context),
                 separatorBuilder: (context,index)=>Padding(
                   padding: const EdgeInsets.all(20.0),
                   child: Container(
                     height: 1,
                     width: double.infinity,
                     color: Colors.grey,
                   ),
                 ),
                 itemCount: list.length)),
          ],
        ),
      );},

    );
  }
}
