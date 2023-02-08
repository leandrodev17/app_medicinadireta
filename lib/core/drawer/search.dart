import 'package:flutter/material.dart';

import 'package:medicinadireta/constants/const_colors.dart';

class Search extends StatelessWidget {
  final Icon? icon;
  final Function()? onPressed;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final InputBorder? errorBorder;
  final InputBorder? disabledBorder;
  final String? hintText;
  final bool autofocus;
  final TextEditingController? controller;

  const Search({
    super.key,
    this.icon,
    this.onPressed,
    this.onChanged,
    this.onSubmitted,
    this.border,
    this.focusedBorder,
    this.enabledBorder,
    this.errorBorder,
    this.disabledBorder,
    this.hintText,
    this.controller,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      width: MediaQuery.of(context).size.width,
      child: TextField(
        controller: controller,
        style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.grey[600]),
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        autofocus: autofocus,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          prefixIcon: Container(
            // color: ConstColors.blue,
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: onPressed,
              icon: icon != null ? Container() : const Icon(Icons.search, color: ConstColors.blue),
            ),
          ),
          border: border,
          focusedBorder: focusedBorder,
          enabledBorder: enabledBorder,
          errorBorder: errorBorder,
          disabledBorder: disabledBorder,
          hintText: hintText ?? 'Procurar por paciente',
          contentPadding: const EdgeInsets.only(left: 66, right: 20, top: 14, bottom: 10),
        ),
      ),
    );
  }
}
