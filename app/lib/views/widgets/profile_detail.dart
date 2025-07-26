import 'package:app/utils/copy_to_clipboard.dart';
import 'package:app/utils/format_date_time.dart';
import 'package:app/views/widgets/item_box.dart';
import 'package:flutter/material.dart';

class ProfileDetail extends StatelessWidget {
  final String placeholder;
  final String value;
  final bool canCopy;
  final bool isDob;
  final bool isGender;
  final Icon? genderIcon;

  const ProfileDetail({
    super.key,
    required this.placeholder,
    required this.value,
    this.canCopy = false,
    this.isDob = false,
    this.isGender = false,
    this.genderIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ItemBox(),
        const SizedBox(width: 12),

        // Text content - handle gender with inline icon differently
        Expanded(
          child:
              isGender && genderIcon != null
                  ? Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(
                            context,
                          ).style.copyWith(fontSize: 20),
                          children: [
                            TextSpan(
                              text: '$placeholder: ',
                              style: const TextStyle(
                                fontSize: 20,
                                fontFamily: 'Vintaface',
                                letterSpacing: 3,
                              ),
                            ),
                            TextSpan(
                              text: formatDateTime(isDob, value),
                              style: TextStyle(
                                fontWeight: FontWeight.w500, // Semi-bold
                                color: Colors.grey[800], // Slightly muted
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 6),
                      genderIcon!,
                    ],
                  )
                  : RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(
                        context,
                      ).style.copyWith(fontSize: 20),
                      children: [
                        TextSpan(
                          text: '$placeholder: ',
                          style: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'Vintaface',
                            letterSpacing: 3,
                          ),
                        ),
                        TextSpan(
                          text: formatDateTime(isDob, value),
                          style: TextStyle(
                            fontWeight: FontWeight.w500, // Semi-bold
                            color: Colors.grey[800], // Slightly muted
                          ),
                        ),
                      ],
                    ),
                  ),
        ),

        // Copy icon (if enabled)
        if (canCopy) ...[
          const SizedBox(width: 8),
          IconButton(
            onPressed: () => copyToClipboard(context, placeholder, value),
            icon: const Icon(Icons.copy, size: 20),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            tooltip: 'Copy $placeholder',
          ),
        ],
      ],
    );
  }
}
