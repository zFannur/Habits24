// import 'package:auto_route/auto_route.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:finplan24/app/app.dart';
// import 'package:finplan24/domain/domain.dart';
// import 'package:finplan24/generated/locale_keys.g.dart';
// import 'package:finplan24/presentation/feature/settings/cubit/cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class PreloadDataScreen extends StatelessWidget {
//   const PreloadDataScreen({
//     required this.excelSheet,
//   });
//
//   final ExcelSheet excelSheet;
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final operations = excelSheet.operations;
//     final plans = excelSheet.plans;
//     return Scaffold(
//       appBar: AppAppBar(
//         name: LocaleKeys.content.tr(),
//         withSettings: false,
//         withArrowBack: true,
//       ),
//       body: PageView(
//         children: [
//           Column(
//             children: [
//               Text(
//                 LocaleKeys.operations.tr(),
//                 style: theme.textTheme.titleLarge,
//               ),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: operations.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return Card(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Text(
//                             operations[index].sum.toString(),
//                             style: theme.textTheme.displayMedium,
//                           ),
//                           Text(
//                             operations[index].category,
//                             style: theme.textTheme.displayMedium,
//                           ),
//                           Text(
//                             operations[index].subCategory,
//                             style: theme.textTheme.displayMedium,
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//           Column(
//             children: [
//               Text(LocaleKeys.plans.tr(), style: theme.textTheme.titleLarge),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: plans.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return Card(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Text(
//                             plans[index].sum.toString(),
//                             style: theme.textTheme.displayMedium,
//                           ),
//                           Text(
//                             plans[index].category,
//                             style: theme.textTheme.displayMedium,
//                           ),
//                           Text(
//                             plans[index].type.name,
//                             style: theme.textTheme.displayMedium,
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           //final router = AutoRouter.of(context);
//           context.read<SettingsCubit>().saveDataFromExcel(
//             operations: operations,
//             plans: plans,
//           );
//           context.replaceRoute(const HomeRoute());
//         },
//         child: const Icon(
//           Icons.save,
//           color: AppColors.orange,
//         ),
//       ),
//     );
//   }
// }