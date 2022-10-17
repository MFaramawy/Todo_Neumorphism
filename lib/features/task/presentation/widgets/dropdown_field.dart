import 'package:todo_app/core/utils/app_colors.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CustomDropDownFromField extends StatelessWidget {
  const CustomDropDownFromField({
    Key? key,
    this.validator,
    this.prefixIcon,
    required this.value,
    required this.items,
    required this.hintText,
    required this.onChanged,
  }) : super(key: key);

  final String value;
  final String hintText;
  final List<String> items;
  final IconData? prefixIcon;
  final void Function(dynamic)? onChanged;
  final String? Function(dynamic)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Neumorphic(
        style: const NeumorphicStyle(
          depth: -5,
          intensity: 5,
        ),
        child: DropdownButtonFormField(
          // value: value,
          onChanged: onChanged,
          validator: validator,
          borderRadius: BorderRadius.circular(20),
          iconEnabledColor: AppColors.primary,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          items: items
              .map((value) => DropdownMenuItem<String>(
                    value: value,
                    child:
                        Center(widthFactor: 1, child: Text(value.toString())),
                  ))
              .toList(),
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
