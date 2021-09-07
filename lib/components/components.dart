import 'package:flutter/material.dart';
import 'package:news_app/modules/web%20view/web_view.dart';


Widget BuildArticlesItem(articls,context) => InkWell(
  onTap: (){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>webViewScreen(articls['url'])));
  },
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        Container(

          width: 120,

          height: 120,

          decoration: BoxDecoration(

              borderRadius:BorderRadius.circular(10.0) ,

                image: DecorationImage(image: NetworkImage("${articls['urlToImage']}"),

                    fit: BoxFit.cover)

            ),

          ),

        SizedBox(width: 15,),

        Expanded(

          child: Container(

            height: 120,

            width: 120,

            child: Column(



              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Expanded(

                  child: Text(   '${articls['title']}',

                    maxLines: 3,

                    overflow: TextOverflow.ellipsis,

                    style: Theme.of(context).textTheme.bodyText1,

                  ),

                ),

                Text('${articls['publishedAt']}',style: TextStyle(

                    fontSize: 10,

                    color: Colors.grey,

                    fontWeight: FontWeight.w600

                ),),

              ],

            ),

          ),

        )

      ],

    ),

  ),
);