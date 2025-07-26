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

        Expanded(
          child: Row(
            children: [
              Text(
                '$placeholder: ',
                style: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'Vintaface',
                  letterSpacing: 3,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Expanded(
                child: Text(
                  isDob ? formatDateTime(true, value) : value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[800],
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),

              if (isGender && genderIcon != null) ...[
                const SizedBox(width: 8),
                genderIcon!,
              ],
            ],
          ),
        ),

        if (canCopy) ...[
          const SizedBox(width: 8),
          IconButton(
            onPressed: () => copyToClipboard(context, placeholder, value),
            icon: const Icon(Icons.copy, size: 20),
            padding: EdgeInsets.zero,
          ),
        ],
      ],
    );
  }
}
