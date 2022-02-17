import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/controller/cubit/news_cubit.dart';
import 'package:news/widgets/components.dart';

class BuinessScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var list = NewsCubit.get(context).business;
        return articleBuilder(list);
      },
    );
  }
}
