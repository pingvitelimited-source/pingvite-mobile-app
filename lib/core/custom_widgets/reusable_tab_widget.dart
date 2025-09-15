import 'package:flutter/material.dart';
import 'package:pingvite/core/constants/enum_tabs.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/model/tab_item.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class ReusableTabWidget extends StatefulWidget {
  final List<TabItem> tabs;
  final TabStyle style;
  final Function(int)? onTabChanged;
  final int initialIndex;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? selectedTextColor;
  final Color? unselectedTextColor;
  final Color? borderColor;
  final double? tabHeight;
  final EdgeInsets? tabPadding;
  final EdgeInsets? contentPadding;
  final bool showContent;

  const ReusableTabWidget({
    super.key,
    required this.tabs,
    this.style = TabStyle.simple,
    this.onTabChanged,
    this.initialIndex = 0,
    this.selectedColor,
    this.unselectedColor,
    this.selectedTextColor,
    this.unselectedTextColor,
    this.borderColor,
    this.tabHeight,
    this.tabPadding,
    this.contentPadding,
    this.showContent = true,
  });

  @override
  State<ReusableTabWidget> createState() => _ReusableTabWidgetState();
}

class _ReusableTabWidgetState extends State<ReusableTabWidget> {
  late int selectedIndex;
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _tabKeys = [];

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
    _tabKeys.addAll(List.generate(widget.tabs.length, (_) => GlobalKey()));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tab Headers
        _buildTabHeaders(textTheme),

        if (widget.showContent) ...[
          const SizedBox(height: 16),
          if (widget.tabs[selectedIndex].content != null)
            Padding(
              padding: widget.contentPadding ?? EdgeInsets.zero,
              child: widget.tabs[selectedIndex].content!,
            ),
        ],
      ],
    );
  }

  Widget _buildTabHeaders(AppTextTheme textTheme) {
    switch (widget.style) {
      case TabStyle.simple:
        return _buildSimpleTabs(textTheme);
      case TabStyle.boxy:
        return _buildBoxyTabs(textTheme);
    }
  }

  Widget _buildSimpleTabs(AppTextTheme textTheme) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    return Material(
      elevation: 3,
      shadowColor: AppColors.black.withValues(alpha: 0.6),
      child: Container(
        color: AppColors.darkPrimaryText,
        child: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: List.generate(widget.tabs.length, (index) {
              final tab = widget.tabs[index];
              final isSelected = selectedIndex == index;
              return GestureDetector(
                key: _tabKeys[index],
                onTap: () {
                  _onTabTap(index);
                  if (_tabKeys[index].currentContext != null) {
                    Scrollable.ensureVisible(
                      _tabKeys[index].currentContext!,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      alignment: 0.5, // keep it nicely centered
                    );
                  }

                  widget.onTabChanged?.call(index);
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  height: widget.tabHeight ?? sl<SizeConfig>().rpx(54),
                  child: AppTexts(
                    text: tab.title,
                    style: isSelected
                        ? textTheme.subheading.copyWith(color: AppColors.black)
                        : textTheme.subheading,
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildBoxyTabs(AppTextTheme textTheme) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: widget.tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final tab = entry.value;
          final isSelected = selectedIndex == index;

          return Container(
            margin: EdgeInsets.only(
              right: index < widget.tabs.length - 1 ? 12 : 0,
            ),
            child: GestureDetector(
              onTap: () => _onTabTap(index),
              child: Container(
                padding:
                    widget.tabPadding ??
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: isSelected
                        ? (widget.selectedColor ??
                              Theme.of(context).primaryColor)
                        : (widget.borderColor ?? Colors.grey.shade300),
                    width: 1.5,
                  ),
                  color: isSelected
                      ? (widget.selectedColor ?? Theme.of(context).primaryColor)
                            .withValues(alpha: 0.1)
                      : Colors.transparent,
                ),
                child: Text(
                  tab.title,
                  style: textTheme.body.copyWith(
                    color: isSelected
                        ? (widget.selectedTextColor ??
                              Theme.of(context).primaryColor)
                        : (widget.unselectedTextColor ?? Colors.grey.shade600),
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _onTabTap(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onTabChanged?.call(index);
  }
}
