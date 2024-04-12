// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class PreloadSavedFilesScreen extends StatelessWidget {
//   const PreloadSavedFilesScreen();
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final habits = context.read<HabitsBloc>().state.operations;
//     final plans = context.read<PlanBloc>().state.plans;
//     final settingsCubit = context.read<SettingsCubit>();
//     return Scaffold(
//       appBar: AppAppBar(
//         name: LocaleKeys.saved_files.tr(),
//         withSettings: false,
//         withArrowBack: true,
//       ),
//       body: Column(
//         children: [
//           SettingsItem(
//             name: 'Автосохранение',
//             widget: SwitchWidget(
//               onChanged: () {
//                 final planBloc = context.read<PlanBloc>();
//                 settingsCubit.registerPeriodicTask(planBloc);
//               },
//               isTrue: settingsCubit.state.isEnabledSaveDataTask,
//             ),
//           ),
//           Expanded(
//             child: BlocConsumer<SettingsCubit, SettingsState>(
//               listener: (context, state) {
//                 if (state.asyncSnapshot?.hasData == true) {
//                   AppSnackBar.showSnackBarWithMessage(
//                     context,
//                     state.asyncSnapshot?.data,
//                   );
//                 }
//
//                 if (state.asyncSnapshot?.hasError == true) {
//                   AppSnackBar.showSnackBarWithError(
//                     context,
//                     ErrorEntity(message: state.asyncSnapshot!.error.toString()),
//                   );
//                 }
//               },
//               builder: (context, state) {
//                 if (state.asyncSnapshot?.connectionState == ConnectionState.waiting) {
//                   return const AppLoader();
//                 }
//
//                 final files = state.files;
//                 return ListView.builder(
//                   itemCount: files.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return InkWell(
//                       onTap: () async {
//                         final navigator = Navigator.of(context);
//                         final excelSheet = await context
//                             .read<SettingsCubit>()
//                             .importFromExcel(filePath: files[index].path);
//                         await navigator.push(
//                           MaterialPageRoute<PreloadDataScreen>(
//                             builder: (context) => PreloadDataScreen(
//                               excelSheet: excelSheet,
//                             ),
//                           ),
//                         );
//                       },
//                       child: Card(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Text(
//                               index.toString(),
//                               style: theme.textTheme.displayMedium,
//                             ),
//                             Text(
//                               '${files[index].uri.pathSegments.last}',
//                               style: theme.textTheme.displayMedium,
//                             ),
//                             IconButton(
//                               onPressed: () {
//                                 context
//                                     .read<SettingsCubit>()
//                                     .sendMessageWithFile(files[index].path);
//                               },
//                               icon: Icon(Icons.share, color: AppColors.white),
//                             ),
//                             IconButton(
//                               onPressed: () async {
//                                 context
//                                     .read<SettingsCubit>()
//                                     .deleteFile(files[index].path);
//                                 context.read<SettingsCubit>().getSavedExcelFiles();
//                               },
//                               icon: Icon(Icons.delete, color: AppColors.red),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: ElevatedButton(
//         onPressed: () {
//           settingsCubit.exportToExcel(operations, plans);
//         },
//         child: Text(
//           LocaleKeys.save_data.tr(),
//           style: theme.textTheme.titleSmall,
//         ),
//       ),
//     );
//   }
// }
