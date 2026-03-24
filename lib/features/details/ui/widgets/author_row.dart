
import 'package:flutter/material.dart';

class AuthorRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Avatar
        CircleAvatar(
          radius: 18,
          backgroundColor: const Color(0xFFFFD9AA),
          child: const Icon(Icons.person_rounded, color: Color(0xFFFF8C00), size: 20),
        ),
        const SizedBox(width: 10),
        // Name + handle
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Yumna Azzahra',
              style: TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1A1A),
              ),
            ),
            Text(
              '@yumnaazzhr01',
              style: TextStyle(fontSize: 11.5, color: Colors.grey[500]),
            ),
          ],
        ),
        const Spacer(),
        // Follow button
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFFFF8C00),
            side: const BorderSide(color: Color(0xFFFF8C00), width: 1.5),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text(
            'Follow',
            style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
