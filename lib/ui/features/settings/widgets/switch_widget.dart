import 'package:flutter/cupertino.dart';

class SwitchWidget extends StatefulWidget {
  SwitchWidget({super.key, required this.isTrue, this.onChanged});

  final bool isTrue;
  final Function()? onChanged;

  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  late bool value;

  @override
  void initState() {
    value = widget.isTrue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      value: value,
      onChanged: (value) {
        setState(() {
          widget.onChanged?.call();
          this.value = value;
        });
      },
    );
  }
}