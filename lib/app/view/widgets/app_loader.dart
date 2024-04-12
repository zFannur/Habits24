import 'package:flutter/material.dart';
import 'package:habits24/app/app.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key, this.withText = true});

  final bool withText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          withText ? Text(
            'Загрузка...',
            style: theme.textTheme.titleLarge,
          ) : SizedBox.shrink(),
          Padding(
            padding: AppPadding.top8,
            child: CircularProgressIndicator(
              color: AppColors.orange,
            ),
          ),
        ],
      ),
    );
  }
}
