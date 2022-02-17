import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/controller/cubit/news_cubit.dart';
import 'package:news/screens/web_view_screen.dart';

Widget buildArticleItem(list) => BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        // NewsCubit cubit = NewsCubit.get(context);
        return InkWell(
          onTap: () {
            navigateTo(context, WebViewScreen(url:list['url'] ,));
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: list['urlToImage'] != null
                        ? DecorationImage(
                            image: NetworkImage(
                              "${list['urlToImage']}",
                            ),
                            fit: BoxFit.cover,
                          )
                        : DecorationImage(
                            image: NetworkImage(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZ19aD8j537tcC2xCMHnch9M7WAVifMq4gNw&usqp=CAU'
                                // "https://logowik.com/content/uploads/images/flutter5786.jpg",
                                ),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Container(
                    height: 120,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            '${list['title']}',
                            style: Theme.of(context).textTheme.bodyText1,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          '${list['publishedAt']}',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

Widget articleBuilder(list,{isSearch= false}) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index]),
        separatorBuilder: (context, index) => Divider(),
        itemCount: list.length,
      ),
      fallback: (context) => isSearch ? Container(): Center(
        child:    CircularProgressIndicator(),
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
