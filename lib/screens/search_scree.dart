// ignore_for_file: missing_return, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/controller/cubit/news_cubit.dart';
import 'package:news/widgets/components.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: searchController,
                  keyboardType: TextInputType.emailAddress,
                  //  onFieldSubmitted: (String? value) {
                  //      if (formKey.currentState!.validate()) {
                  //         ShoploginCubit.get(context).userLogin(
                  //                   email: emailController.text,
                  //                   password: passwordController.text);
                  //             }
                  //           },
                  onChanged: (value) {
                    NewsCubit.get(context).getSearch(value);
                    NewsCubit.get(context).search = [];
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'search entry is required';
                    }
                    // return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Search',
                    focusColor: Colors.black,
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              NewsCubit.get(context).search.isEmpty ? Container():  Expanded(child: articleBuilder(list, isSearch: true)),
            ],
          ),
        );
      },
    );
  }
}
