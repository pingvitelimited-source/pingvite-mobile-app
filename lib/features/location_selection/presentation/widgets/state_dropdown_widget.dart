import 'package:flutter/material.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/service_locator_dependencies.dart';
import 'package:pingvite/features/location_selection/data/models/location_model.dart';

class StateDropdownWidget extends StatefulWidget {
  final List<StateModel> states;
  final String? selectedStateName;
  final Function(String, String) onStateSelected;

  const StateDropdownWidget({
    super.key,
    required this.states,
    this.selectedStateName,
    required this.onStateSelected,
  });

  @override
  State<StateDropdownWidget> createState() => _StateDropdownWidgetState();
}

class _StateDropdownWidgetState extends State<StateDropdownWidget> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showStateBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            List<StateModel> filteredStates = widget.states;
            if (_searchController.text.isNotEmpty) {
              filteredStates = widget.states
                  .where(
                    (state) => state.name.toLowerCase().contains(
                      _searchController.text.toLowerCase(),
                    ),
                  )
                  .toList();
            }

            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                padding: EdgeInsets.all(sl<SizeConfig>().rpx(16)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _searchController,
                      onChanged: (_) => setModalState(() {}),
                      decoration: InputDecoration(
                        hintText: 'Search states...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            sl<SizeConfig>().rpx(8),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: sl<SizeConfig>().rpx(16)),
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredStates.length,
                        itemBuilder: (context, index) {
                          final state = filteredStates[index];
                          return ListTile(
                            title: AppTexts(text: state.name),
                            onTap: () {
                              widget.onStateSelected(state.id, state.name);
                              Navigator.pop(context);
                              _searchController.clear();
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final sizeConfig = sl<SizeConfig>();

    return GestureDetector(
      onTap: () => _showStateBottomSheet(context),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: sizeConfig.rpx(16),
          vertical: sizeConfig.rpx(14),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(sizeConfig.rpx(12)),
          border: Border.all(color: AppColors.blue.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppTexts(
              text: widget.selectedStateName ?? 'Choose a state',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: widget.selectedStateName != null
                    ? AppColors.black
                    : AppColors.lightSecondaryText,
                fontWeight: FontWeight.w500,
              ),
            ),
            Icon(Icons.keyboard_arrow_down, color: AppColors.blue),
          ],
        ),
      ),
    );
  }
}
