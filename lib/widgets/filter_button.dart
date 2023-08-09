import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_provider/models/todo_model.dart';
import 'package:todo_app_provider/providers/providers.dart';
import 'package:todo_app_provider/utils/color_utils.dart';

Widget filterButton(BuildContext context, Filter filter) {
  return TextButton(
    onPressed: () {
      context.read<TodoFilter>().changeFilter(filter);
    },
    child: Text(
      filter == Filter.all
          ? 'All'
          : filter == Filter.active
              ? 'Active'
              : 'Completed',
      style: TextStyle(
        fontSize: 18.0,
        color: textColor(context, filter),
      ),
    ),
  );
}
