import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class TopMenu extends StatelessWidget {
  const TopMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(255, 116, 65, 1),
            Color.fromRGBO(255, 191, 102, 1),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Field
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25), // Light shadow
                      blurRadius: 4, // Softens the shadow
                      offset: Offset(0, 4), // Moves the shadow downwards
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Search or ask a question',
                    hintStyle: TextStyle(
                      color: AppColor.paragraphBlack,
                      fontSize: 14,
                    ),
                    prefixIcon: const Icon(Icons.search, color: AppColor.paragraphBlack),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 8),
              // Hardcoded Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // First button with two icons
                  InkWell(
                    onTap: () {
                      // Add your functionality here
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Row(
                      children: [
                        const Icon(Icons.location_pin, color: AppColor.paragraphBlack, size: 16),
                        const SizedBox(width: 3),
                        const Text(
                          'Locker C',
                          style: TextStyle(
                            color: AppColor.paragraphBlack,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 3),
                        const Icon(Icons.keyboard_arrow_down_rounded, color: AppColor.paragraphBlack, size: 16),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Second button (Help)
                  InkWell(
                    onTap: () {
                      // Add your functionality here
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: const Text(
                      'Help',
                      style: TextStyle(
                        color: AppColor.paragraphBlack,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Third button (How does it work?)
                  InkWell(
                    onTap: () {
                      // Add your functionality here
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: const Text(
                      'How does it work?',
                      style: TextStyle(
                        color: AppColor.paragraphBlack,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
