import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  const InputField({
    Key? key,
    this.icon,
    required this.hint,
    this.prefixIcon,
    this.password,
    this.controller,
    this.validator,
  }) : super(key: key);
  final Icon? icon;
  final String hint;
  final Icon? prefixIcon;
  final bool? password;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 1),
              color: Colors.grey.shade200,
              blurRadius: 18),
        ],
      ),
      child: SizedBox(
        height: 45,
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                textCapitalization: widget.password ?? false
                    ? TextCapitalization.none
                    : TextCapitalization.words,
                validator: widget.validator,
                controller: widget.controller,
                obscureText: widget.password == true ? !visible : false,
                decoration: InputDecoration(
                  prefixIcon: widget.icon,
                  hintText: widget.hint,
                  hintStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                ),
              ),
            ),
            widget.prefixIcon == null
                ? const SizedBox.shrink()
                : GestureDetector(
                    child: visible
                        ? widget.prefixIcon!
                        : const Icon(
                            Icons.visibility_off,
                            color: Colors.grey,
                          ),
                    onTap: () {
                      setState(() {
                        visible = !visible;
                      });
                    },
                  )
          ],
        ),
      ),
    );
  }
}
