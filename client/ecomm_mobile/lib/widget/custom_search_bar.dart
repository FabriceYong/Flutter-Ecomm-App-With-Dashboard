import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key, required this.controller, this.onChanged});
  final TextEditingController controller;
  final void Function(String)? onChanged;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  bool isExpanded = false;
  final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
          if (!isExpanded) {
            _focusNode.unfocus();
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isExpanded ? Colors.white : Colors.grey.shade200),
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: FocusScope(
          node: FocusScopeNode(),
          child: Row(
            children: [
              const Icon(Iconsax.search_normal),
              const Gap(10),
              Expanded(
                  child: TextField(
                focusNode: _focusNode,
                controller: widget.controller,
                decoration: const InputDecoration(
                    hintText: 'Search...', border: InputBorder.none),
                autofocus: false,
                onChanged: widget.onChanged,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
