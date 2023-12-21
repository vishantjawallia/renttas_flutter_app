// ignore_for_file: no_logic_in_create_state

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final Key? formKey;
  final bool? obscureText;
  final IconData? iconData;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? enabled;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final void Function()? onObscureTap;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  const CustomTextField({
    super.key,
    this.padding,
    this.margin,
    this.hintText,
    this.obscureText,
    this.controller,
    this.iconData,
    this.onObscureTap,
    this.focusNode,
    this.inputFormatters,
    this.validator,
    this.formKey,
    this.enabled,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState(obscureText);
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool? isObscureText;

  _CustomTextFieldState(this.isObscureText);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding ?? const EdgeInsets.symmetric(vertical: 10),
      margin: widget.margin ?? const EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xffEFE3E3),
      ),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: TextInputType.visiblePassword,
        obscureText: widget.obscureText != null ? (isObscureText ?? widget.obscureText!) : false,
        focusNode: widget.focusNode,
        validator: widget.validator,
        inputFormatters: widget.inputFormatters ??
            [
              // LengthLimitingTextInputFormatter(10),
            ],
        style: const TextStyle(color: Colors.black87),
        decoration: InputDecoration(
          enabled: widget.enabled ?? true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintText: widget.hintText ?? "Password",
          hintStyle: const TextStyle(color: Colors.black38),
          filled: true,
          fillColor: Colors.transparent,
          isDense: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          prefixIcon: Icon(
            widget.iconData ?? Icons.lock_rounded,
            size: 24,
            color: const Color(0xff54854C),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
            child: GestureDetector(
              onTap: () {
                if (widget.obscureText != null) {
                  setState(() {
                    isObscureText = !isObscureText!;
                  });
                }
              },
              child: widget.obscureText != null
                  ? Icon(
                      (isObscureText ?? widget.obscureText!) ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                      size: 24,
                      color: Colors.grey,
                    )
                  : const SizedBox(),
            ),
          ),
        ),
      ),
    );
  }
}
