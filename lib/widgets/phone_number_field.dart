import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/validators.dart';

class PhoneNumberField extends StatefulWidget {
  final String? label;
  final String? initialValue;
  final CountryCode? initialCountryCode;
  final Function(String, CountryCode)? onChanged;
  final String? Function(String?, CountryCode?)? validator;
  final bool enabled;

  const PhoneNumberField({
    Key? key,
    this.label,
    this.initialValue,
    this.initialCountryCode,
    this.onChanged,
    this.validator,
    this.enabled = true,
  }) : super(key: key);

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  late TextEditingController _controller;
  CountryCode? _selectedCountry;
  late FocusNode _focusNode;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue ?? '');
    _selectedCountry =
        widget.initialCountryCode ?? Validators.countryCodes.first;
    _focusNode = FocusNode();

    // Add listener for focus changes
    _focusNode.addListener(() {
      setState(() {});
    });

    // Add listener for text changes to show/hide clear button
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onPhoneNumberChanged(String value) {
    if (_selectedCountry != null) {
      // Don't format while typing to prevent cursor jumping
      widget.onChanged?.call(value, _selectedCountry!);

      // Validate and update error text
      setState(() {
        _errorText = widget.validator?.call(value, _selectedCountry);
      });
    }
  }

  void _onCountryChanged(CountryCode? newCountry) {
    if (newCountry != null) {
      setState(() {
        _selectedCountry = newCountry;

        // Always re-validate the current text against the new country
        if (_controller.text.isNotEmpty) {
          _errorText = widget.validator?.call(_controller.text, newCountry);
        } else {
          _errorText = null;
        }
      });

      // Notify parent about the country change
      widget.onChanged?.call(_controller.text, newCountry);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
        ],

        // Main phone number container
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _errorText != null
                  ? Theme.of(context).colorScheme.error
                  : _focusNode.hasFocus
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.outline.withOpacity(0.5),
              width: _focusNode.hasFocus || _errorText != null ? 2 : 1,
            ),
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Row(
            children: [
              // Country Code Dropdown
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.surfaceVariant.withOpacity(0.2),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(11),
                    bottomLeft: Radius.circular(11),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<CountryCode>(
                    value: _selectedCountry,
                    isDense: true,
                    onChanged: widget.enabled ? _onCountryChanged : null,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.6),
                      size: 16,
                    ),
                    dropdownColor: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                    elevation: 4,
                    items: Validators.countryCodes.map((country) {
                      return DropdownMenuItem<CountryCode>(
                        value: country,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _getCountryFlag(country.code),
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              country.dialCode,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    selectedItemBuilder: (context) {
                      return Validators.countryCodes.map((country) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _getCountryFlag(country.code),
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              country.dialCode,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        );
                      }).toList();
                    },
                  ),
                ),
              ),

              // Divider line
              Container(
                width: 1,
                height: 40,
                color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
              ),

              // Phone Number Input - No inner border
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    enabled: widget.enabled,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(
                        _selectedCountry?.maxLength ?? 15,
                      ),
                    ],
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: _selectedCountry?.placeholder ?? 'Phone number',
                      hintStyle: TextStyle(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.5),
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      suffixIcon: _controller.text.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                _controller.clear();
                                widget.onChanged?.call('', _selectedCountry!);
                                setState(() {
                                  _errorText = widget.validator?.call(
                                    '',
                                    _selectedCountry,
                                  );
                                });
                              },
                              icon: Icon(
                                Icons.clear,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withOpacity(0.5),
                                size: 18,
                              ),
                            )
                          : null,
                    ),
                    onChanged: _onPhoneNumberChanged,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Error message - displayed below the field
        if (_errorText != null) ...[
          const SizedBox(height: 6),
          Text(
            _errorText!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ],

        // Format hint
        if (_selectedCountry != null && _errorText == null) ...[
          const SizedBox(height: 6),
          Text(
            'Format: ${_selectedCountry!.dialCode} ${_selectedCountry!.placeholder}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ],
    );
  }

  String _getCountryFlag(String countryCode) {
    const flagMap = {
      'NP': '🇳🇵',
      'US': '🇺🇸',
      'GB': '🇬🇧',
      'CA': '🇨🇦',
      'AU': '🇦🇺',
      'DE': '🇩🇪',
      'FR': '🇫🇷',
      'IN': '🇮🇳',
      'JP': '🇯🇵',
      'KR': '🇰🇷',
      'BR': '🇧🇷',
      'MX': '🇲🇽',
      'CN': '🇨🇳',
    };
    return flagMap[countryCode] ?? '🌍';
  }
}
