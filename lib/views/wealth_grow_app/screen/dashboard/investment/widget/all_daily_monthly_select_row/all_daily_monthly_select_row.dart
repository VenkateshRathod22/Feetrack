import 'package:flutter/material.dart';
import 'package:vlr/views/wealth_grow_app/screen/dashboard/investment/widget/all_daily_monthly_select_row/select_widget.dart';

class FilterSelectionSection extends StatefulWidget {
  const FilterSelectionSection({super.key});

  @override
  State<FilterSelectionSection> createState() => _FilterSelectionSectionState();
}

class _FilterSelectionSectionState extends State<FilterSelectionSection> {
  // 1. Track the currently selected index (0 is "All" by default)
  int selectedIndex = 0;

  // 2. Keep just the raw data (titles) here
  final List<String> filterOptions = ["All", "Daily", "Monthly", "Yearly"];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(filterOptions.length, (index) {
        return SelectWidget(
          selectWidgetModel: SelectWidgetModel(
            title: filterOptions[index],
            // 3. It is selected if the current index matches the tapped index
            isSelect: selectedIndex == index,
            onTap: () {
              // 4. Update state to the new index
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        );
      }),
    );
  }
}
