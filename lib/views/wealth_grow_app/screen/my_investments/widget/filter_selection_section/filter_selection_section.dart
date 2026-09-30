import 'package:flutter/material.dart';
import 'package:vlr/views/wealth_grow_app/screen/my_investments/widget/filter_selection_section/select_widget.dart';

class FilterSelectionSection extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const FilterSelectionSection({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    const List<String> filterOptions = [
      "Actives",
      "Withdraws",
    ];

    return Row(
      children: List.generate(
        filterOptions.length,
        (index) {
          return SelectWidget(
            selectWidgetModel: SelectWidgetModel(
              title: filterOptions[index],
              isSelect: selectedIndex == index,
              onTap: () {
                onSelected(index);
              },
            ),
          );
        },
      ),
    );
  }
}
