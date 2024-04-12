import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habits24/app/app.dart';
import 'package:habits24/generated/locale_keys.g.dart';
import 'package:habits24/ui/features/settings/settings.dart';

class RecommendationDialog extends StatefulWidget {
  const RecommendationDialog({
    super.key,
  });

  @override
  State<RecommendationDialog> createState() => _RecommendationDialogState();
}

class _RecommendationDialogState extends State<RecommendationDialog> {
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SimpleDialog(
      children: [
        Form(
          key: formKey,
          child: Padding(
            padding: AppPadding.all16,
            child: Column(
              children: [
                Padding(
                  padding: AppPadding.top8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppButton(
                        onPressed: () {
                          context.popRoute();
                        },
                        child: Text(
                          LocaleKeys.back.tr(),
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                      AppButton(
                        onPressed: () {
                          context.read<RecommendationsCubit>().addRecommendation(controller.text);
                          controller.clear();
                        },
                        child: Text(
                          LocaleKeys.add.tr(),
                          style: theme.textTheme.titleMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: AppPadding.top8,
                  child: AppTextField(
                    labelText: LocaleKeys.name.tr(),
                    controller: controller,
                    maxLines: 3,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  child: BlocBuilder<RecommendationsCubit, RecommendationsState>(
                    builder: (
                      BuildContext context,
                      state,
                    ) {
                      if (state.asyncSnapshot == const AsyncSnapshot.waiting()) {
                        return const AppLoader();
                      }

                      return ListView.separated(
                        itemCount: state.recommendations.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 8),
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            children: [
                              IconButton(onPressed: () {
                                context.read<RecommendationsCubit>().deleteRecommendation(index);
                              }, icon: AppIcons.delete),
                              Expanded(
                                child: Text(
                                  state.recommendations[index],
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
