import 'package:final_project/components/text/text_widget.dart';
import 'package:final_project/utils/constants/colors.dart';
import 'package:final_project/utils/constants/spaces.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget(
      {super.key,
      this.preIcon,
      required this.hint,
      required this.lable,
      this.maxLines = 1,
      this.controller,
      this.radius,
      this.textLabelSize,
      this.onSubmitted,
      this.onChanged});

  final String lable;
  final double? textLabelSize;
  final Icon? preIcon;
  final String hint;
  final int maxLines;
  final TextEditingController? controller;
  final double? radius;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextWidget(
            text: widget.lable,
            size: widget.textLabelSize ?? 20,
            isBold: true,
          ),
          kVSpace8,
          TextField(
            onSubmitted: widget.onSubmitted,
            controller: widget.controller,
            onChanged: widget.onChanged,
            cursorColor: ETheme.colors.primary,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle:
                  TextStyle(color: ETheme.colors.primary.withOpacity(0.6)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radius ?? 20.0),
                  borderSide: BorderSide(color: ETheme.colors.primary)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radius ?? 20.0),
                  borderSide: BorderSide(color: ETheme.colors.primary)),
              prefixIcon: widget.preIcon,
              prefixIconColor: ETheme.colors.primary,
              suffixIconColor: ETheme.colors.primary,
              suffixIcon:
                  (widget.lable.toLowerCase().compareTo("password") == 0)
                      ? GestureDetector(
                          onTap: () => setState(() {
                            isVisible = !isVisible;
                          }),
                          child: isVisible
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                        )
                      : null,
            ),
            maxLines: widget.maxLines,
            minLines: 1,
            obscureText:
                widget.lable.toLowerCase().compareTo("password") == 0 &&
                    !isVisible,
          ),
        ],
      ),
    );
  }
}
