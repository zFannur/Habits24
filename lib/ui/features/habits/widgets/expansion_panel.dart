import 'package:flutter/material.dart';

class ExpansionPanelWidget extends StatefulWidget {
  const ExpansionPanelWidget({
    super.key,
    required this.body,
    required this.title,
    this.isExpanded,
  });

  final Widget body;
  final String title;
  final bool? isExpanded;

  @override
  State<ExpansionPanelWidget> createState() => _ExpansionPanelWidgetState();
}

class _ExpansionPanelWidgetState extends State<ExpansionPanelWidget> {
  bool _isExpanded = false;

  @override
  void initState() {
    _isExpanded = widget.isExpanded ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _isExpanded = isExpanded;
        });
      },
      children: [
        ExpansionPanel(
          backgroundColor: theme.primaryColor,
          canTapOnHeader: true,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return SizedBox(
              height: 50,
              child: ListTile(
                title: Text(widget.title, style: theme.textTheme.titleLarge),
              ),
            );
          },
          body: widget.body,
          isExpanded: _isExpanded,
        ),
      ],
    );
  }
}
