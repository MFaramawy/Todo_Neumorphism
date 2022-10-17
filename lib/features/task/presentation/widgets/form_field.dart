import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.onTap,
    this.prefixIcon,
    this.readOnly = false,
    required this.hintText,
    required this.controller,
    this.validator,
  }) : super(key: key);

  final bool? readOnly;
  final String hintText;
  final IconData? prefixIcon;
  final void Function()? onTap;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Neumorphic(
        style: const NeumorphicStyle(
          depth: -5,
          intensity: 5,
        ),
        child: TextFormField(
          onTap: onTap,
          readOnly: readOnly!,
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            filled: true,
            hintText: hintText,
            prefixIcon: Icon(prefixIcon),
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
