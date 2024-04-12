// import 'dart:io';
//
// import 'package:excel/excel.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:uuid/uuid.dart';
//
// class ExcelUseCase {
//   ExcelUseCase();
//   final AppShare appShare = AppShare();
//   final AppPermissionsHandler appPermissionsHandler = AppPermissionsHandler();
//
//   static const operationsTable = 'operations';
//   static const plansTable = 'plans';
//
//   Future<void> exportToExcel(List<Operation> operations, List<Plan> plans) async {
//       var excel = Excel.createExcel();
//       var sheetOperations = excel[operationsTable];
//       //var sheetOperations = excel[excel.getDefaultSheet()!]; // Получаем первый лист
//
//       // Заголовки для файла Excel
//       var headersOperations = [
//         'ID',
//         'Date',
//         'Type',
//         'Category',
//         'Sum',
//         'SubCategory',
//         'Note'
//       ];
//
//       // Заполнение заголовков
//       headersOperations.asMap().forEach((index, header) => sheetOperations.updateCell(
//           CellIndex.indexByColumnRow(columnIndex: index, rowIndex: 0),
//           TextCellValue(header)));
//
//       // Заполнение данных
//       for (int i = 0; i < operations.length; i++) {
//         var operation = operations[i];
//         sheetOperations
//           ..updateCell(
//               CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1),
//               TextCellValue(operation.id))
//           ..updateCell(
//               CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i + 1),
//               DateCellValue(
//                   year: operation.date.year,
//                   month: operation.date.month,
//                   day: operation.date.day),
//               cellStyle: CellStyle(
//                 numberFormat: NumFormat.defaultDate,
//               ))
//           ..updateCell(
//               CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i + 1),
//               TextCellValue(const TypeConverter().toJson(operation.type)))
//           ..updateCell(
//               CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i + 1),
//               TextCellValue(operation.category))
//           ..updateCell(
//               CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i + 1),
//               IntCellValue(operation.sum),
//               cellStyle: CellStyle(
//                 numberFormat: NumFormat.defaultNumeric,
//               ))
//           ..updateCell(
//               CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i + 1),
//               TextCellValue(operation.subCategory))
//           ..updateCell(
//               CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i + 1),
//               TextCellValue(operation.note));
//       }
//
//       var sheetPlans = excel[plansTable];
//
//       // Заголовки для файла Excel
//       var headersPlans = [
//         'ID',
//         'Date',
//         'Type',
//         'Category',
//         'Sum',
//         'Fact',
//         'Note'
//       ];
//
//       // Заполнение заголовков
//       headersPlans.asMap().forEach((index, header) => sheetPlans.updateCell(
//           CellIndex.indexByColumnRow(columnIndex: index, rowIndex: 0),
//           TextCellValue(header)));
//
//       // Заполнение данных
//       for (int i = 0; i < plans.length; i++) {
//         var plan = plans[i];
//         sheetPlans
//           ..updateCell(
//               CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1),
//               TextCellValue(plan.id))
//           ..updateCell(
//               CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i + 1),
//               DateCellValue(
//                   year: plan.date.year,
//                   month: plan.date.month,
//                   day: plan.date.day),
//               cellStyle: CellStyle(
//                 numberFormat: NumFormat.defaultDate,
//               ))
//           ..updateCell(
//               CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i + 1),
//               TextCellValue(const TypeConverter().toJson(plan.type)))
//           ..updateCell(
//               CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i + 1),
//               TextCellValue(plan.category))
//           ..updateCell(
//               CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i + 1),
//               IntCellValue(plan.sum),
//               cellStyle: CellStyle(
//                 numberFormat: NumFormat.defaultNumeric,
//               ))
//           ..updateCell(
//               CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i + 1),
//               IntCellValue(plan.fact),
//               cellStyle: CellStyle(
//                 numberFormat: NumFormat.defaultNumeric,
//               ))
//           ..updateCell(
//               CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i + 1),
//               TextCellValue(plan.note));
//       }
//
//       await appPermissionsHandler.requestStoragePermission();
//       // Сохранение файла Excel
//       //String? directory = await FilePicker.platform.getDirectoryPath();
//
//       final fileBytes = excel.save();
//       final directory = (await getApplicationDocumentsDirectory()).path;
//       final path = '$directory/xlsx-${DateTime.now()}.xlsx';
//       File(path)
//         ..createSync(recursive: true)
//         ..writeAsBytesSync(fileBytes!);
//
//       //await appShare.sendMessageWithFile(path);
//   }
//
//   // Импорт операций из Excel файла
//   Future<ExcelSheet> importOperationsFromExcel({String? filePath}) async {
//     await appPermissionsHandler.requestStoragePermission();
//
//     String path = filePath ?? '';
//
//     if (filePath == null) {
//       // Использование FilePicker для выбора файла
//       final result = await FilePicker.platform.pickFiles(
//         allowedExtensions: ['xlsx'],
//         // Убедитесь, что указан правильный тип расширения
//         type: FileType.custom,
//       );
//
//       if (result == null || result.files.single.path == null) {
//         // Пользователь отменил выбор файла
//         return ExcelSheet(operations: [], plans: []);
//       }
//
//       // Получение пути к выбранному файлу
//       path = result.files.single.path!;
//     }
//
//     final file = File(path);
//     final bytes = file.readAsBytesSync();
//     final excel = Excel.decodeBytes(bytes);
//
//     // Предполагаем, что первый лист является нужным листом
//     final sheetOperations = excel.tables[operationsTable]!;
//     final sheetPlans = excel.tables[plansTable]!;
//     //final sheet = excel.sheets.values.first;
//
//     final operations = <Operation>[];
//     // Пропускаем первую строку с заголовками
//     for (final row in sheetOperations.rows.skip(1)) {
//       // Проверяем что row ID содержит id
//       if (row[0]?.value.toString() != 'null') {
//         // Добавляем новый объект Operation в список
//         // Здесь используется "?? DateTime.now()" как запасной вариант, если дата отсутствует или некорректна
//         final operation = Operation(
//           id: row[0]?.value.toString() ?? const Uuid().v4(),
//           // ID операции
//           date: DateTime.tryParse(row[1]?.value.toString() ?? DateTime.now().toString()) ??
//               DateTime.now(),
//           // Дата операции, с возможностью исправления неправильных данных
//           type: const TypeConverter()
//               .fromJson(row[2]?.value.toString() ?? 'expense'),
//           category: row[3]?.value.toString() ?? '',
//           sum: int.tryParse(row[4]?.value.toString() ?? '0') ?? 0,
//           subCategory: row[5]?.value.toString() == 'null' ? '' : row[5]?.value.toString() ?? '',
//           note: row[6]?.value.toString() == 'null' ? '' : row[6]?.value.toString() ?? '',
//         );
//         operations.add(operation);
//       } else {
//         // Возможно, стоит залогировать ошибку или уведомить пользователя
//       }
//     }
//
//     final plans = <Plan>[];
//     // Пропускаем первую строку с заголовками
//     for (final row in sheetPlans.rows.skip(1)) {
//       // Проверяем что row ID содержит id
//       if (row[0]?.value.toString() != 'null') {
//         // Добавляем новый объект Operation в список
//         // Здесь используется "?? DateTime.now()" как запасной вариант, если дата отсутствует или некорректна
//         final plan = Plan(
//           id: row[0]?.value.toString() ?? const Uuid().v4(),
//           // ID операции
//           date: DateTime.tryParse(row[1]?.value.toString() ?? DateTime.now().toString()) ??
//               DateTime.now(),
//           // Дата операции, с возможностью исправления неправильных данных
//           type: const TypeConverter()
//               .fromJson(row[2]?.value.toString() ?? 'expense'),
//           category: row[3]?.value.toString() ?? '',
//           sum: int.tryParse(row[4]?.value.toString() ?? '0') ?? 0,
//           fact: int.tryParse(row[5]?.value.toString() ?? '0') ?? 0,
//           note: row[6]?.value.toString() == 'null' ? '' : row[6]?.value.toString() ?? '',
//         );
//         plans.add(plan);
//       } else {
//         // Возможно, стоит залогировать ошибку или уведомить пользователя
//       }
//     }
//
//     return ExcelSheet(operations: operations, plans: plans);
//   }
// }