import 'package:flutter/material.dart';
import 'package:habits24/app/app.dart';

class CustomTextFieldWithList extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final String? name;
  final void Function()? onAdd;
  final void Function(String)? onDelete;
  final List<String> list;

  const CustomTextFieldWithList({
    super.key,
    required this.controller,
    required this.labelText,
    this.validator,
    this.name,
    required this.list, this.onAdd, this.onDelete,
  });

  @override
  State<CustomTextFieldWithList> createState() => _CustomTextFieldWithListState();
}

class _CustomTextFieldWithListState extends State<CustomTextFieldWithList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: widget.name != null,
          child: Padding(
            padding: AppPadding.top8,
            child: Text(
              widget.name ?? '',
              style: AppTextStyle.bold24,
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: AppTextField(
                labelText: widget.labelText,
                controller: widget.controller,
                validator: widget.validator,
              ),
            ),
            IconButton(
              onPressed: () {
                widget.onAdd?.call();
                setState(() {});
              },
              icon: AppIcons.add,
            ),
          ],
        ),
        Wrap(
          children: List.generate(
            widget.list.length,
            (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.list[index],
                        overflow: TextOverflow.fade,
                        style: AppTextStyle.medium14,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        widget.onDelete?.call(widget.list[index]);
                        setState(() {});
                      },
                      icon: AppIcons.delete,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
