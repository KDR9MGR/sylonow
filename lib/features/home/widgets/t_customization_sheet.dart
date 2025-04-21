import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sylonow/utils/constants/app_colors.dart';
import 'package:sylonow/features/home/widgets/t_option_tile.dart';

class TCustomizationSheet extends StatefulWidget {
  const TCustomizationSheet({
    super.key,
  });

  @override
  State<TCustomizationSheet> createState() => _TCustomizationSheetState();
}

class _TCustomizationSheetState extends State<TCustomizationSheet> {
  String? _selectedTheme;
  String? _selectedVenue;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final TextEditingController _commentController = TextEditingController();

  bool get _isFormValid =>
      _selectedTheme != null &&
      _selectedVenue != null &&
      _selectedDate != null &&
      _selectedTime != null;

  void _handleContinue() {
    if (!_isFormValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Navigator.pop(context); // Close bottom sheet
    context.push(
      '/checkout',
      extra: {
        'theme': _selectedTheme!,
        'venue': _selectedVenue!,
        'date': _selectedDate!,
        'time': _selectedTime!,
        'comment': _commentController.text,
      },
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Widget _buildThemeOptions() {
    return Column(
      children: [
        TOptionTile(
          title: 'Modern Minimalist',
          isSelected: _selectedTheme == 'Modern Minimalist',
          onTap: () => setState(() => _selectedTheme = 'Modern Minimalist'),
        ),
        TOptionTile(
          title: 'Traditional',
          isSelected: _selectedTheme == 'Traditional',
          onTap: () => setState(() => _selectedTheme = 'Traditional'),
        ),
        TOptionTile(
          title: 'Contemporary',
          isSelected: _selectedTheme == 'Contemporary',
          onTap: () => setState(() => _selectedTheme = 'Contemporary'),
        ),
      ],
    );
  }

  Widget _buildVenueOptions() {
    return Column(
      children: [
        TOptionTile(
          title: 'Indoor',
          isSelected: _selectedVenue == 'Indoor',
          onTap: () => setState(() => _selectedVenue = 'Indoor'),
        ),
        TOptionTile(
          title: 'Outdoor',
          isSelected: _selectedVenue == 'Outdoor',
          onTap: () => setState(() => _selectedVenue = 'Outdoor'),
        ),
        TOptionTile(
          title: 'Both',
          isSelected: _selectedVenue == 'Both',
          onTap: () => setState(() => _selectedVenue = 'Both'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) => SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Customise / Requirements',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              
              // Select theme section
              const Text(
                'Select theme',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              _buildThemeOptions(),
              const SizedBox(height: 24),

              // Venue type section
              const Text(
                'Venue type',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              _buildVenueOptions(),
              const SizedBox(height: 24),

              // Date and Time section
              const Text(
                'Time slot and Date',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 365)),
                        );
                        if (date != null) {
                          setState(() => _selectedDate = date);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade200),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _selectedDate != null 
                              ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                              : 'Select Date',
                          style: TextStyle(
                            color: _selectedDate != null ? Colors.black : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (time != null) {
                          setState(() => _selectedTime = time);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade200),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _selectedTime != null 
                              ? _selectedTime!.format(context)
                              : 'Select Time',
                          style: TextStyle(
                            color: _selectedTime != null ? Colors.black : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Comment section
              TextField(
                controller: _commentController,
                decoration: const InputDecoration(
                  hintText: 'Add comment (optional)',
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 24),

              // Continue button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: _isFormValid ? TColors.primary : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: _isFormValid ? _handleContinue : null,
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 