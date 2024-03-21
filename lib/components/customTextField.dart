import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextFormField extends StatefulWidget {
  final String? hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final IconData? suffixIconVisible;
  final IconData? suffixIconNull;
  final String? prefixText;
  final EdgeInsets? contentPadding;
  final bool obscureText;
  final TextEditingController? controller;
  final String? labelText;
  final TextInputType keyboardType;
  final bool enabled;
  final double? prefixIconsSize;

  void Function()? onTap;
  final void Function(String)? onFieldSubmitted;
  final String? initialValue;
  void Function(String)? onChanged;
  String? errorText;
  int? minLines;
  int? maxLines;

  double? suffixIconSize;

  TextDirection? textDirection;

  final TextAlign? textAlign;
 String? Function(String?)? validator;

  CustomTextFormField({
    Key? key,
    this.hintText,
    this.onTap,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixIconVisible,
    this.suffixIconNull,
    this.prefixText,
    this.contentPadding,
    this.obscureText = false,
    this.controller,
    this.labelText,
    this.prefixIconsSize,
    this.onFieldSubmitted,
    this.initialValue,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.errorText,
    this.textAlign,
    this.minLines,
    this.maxLines=1,
    this.textDirection,
   this.validator,
    this.suffixIconSize,
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
     // focusNode: FocusNode(),

      textDirection: widget.textDirection,
      textAlign: widget.textAlign??TextAlign.start,
      onChanged: widget.onChanged,
      validator: widget.validator,
      initialValue: widget.initialValue,
      onTap: widget.onTap,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      controller: widget.controller,
      enabled: widget.enabled,
      onFieldSubmitted: widget.onFieldSubmitted,
      obscureText: _obscureText,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(

        hintText: widget.hintText?.tr,
        labelText: widget.labelText?.tr,
        prefixIcon: widget.prefixIcon != null
            ? Icon(
                widget.prefixIcon,
                size: widget.prefixIconsSize,
              )
            : null,
        suffixIcon: widget.suffixIcon != null
            ? IconButton(
                icon: Icon(_obscureText
                    ? widget.suffixIcon
                    : widget.suffixIconVisible,size: widget.suffixIconSize,),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : (widget.keyboardType == TextInputType.visiblePassword
                ? IconButton(
                    icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,size: widget.suffixIconSize,),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : (widget.suffixIconNull != null
                    ? Icon(widget.suffixIconNull,size: widget.suffixIconSize,)
                    : null)),
        prefixText: widget.prefixText?.tr,
        contentPadding: widget.contentPadding,
        errorText: widget.errorText?.tr,
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(15.0),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(15.0),
        ),
        errorMaxLines: 2,
        errorStyle: const TextStyle(fontSize: 10),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(15.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:  BorderSide(color: Colors.purple.shade100, width: 1.5),
          borderRadius: BorderRadius.circular(15.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}
