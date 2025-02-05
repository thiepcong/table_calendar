import 'package:flutter/material.dart';

import '../customization/calendar_choose_year_style.dart';

class CalendarChooseYear extends StatefulWidget {
  const CalendarChooseYear({
    super.key,
    required this.focusedDay,
    required this.firstDay,
    required this.lastDay,
    this.onYearDifChange,
    required this.onPageYearControllerCreated,
    required this.calendarChooseYearStyle,
    this.onSelectedYear,
  });

  final DateTime focusedDay;
  final DateTime firstDay;
  final DateTime lastDay;
  final void Function(DateTime)? onYearDifChange;
  final void Function(PageController) onPageYearControllerCreated;
  final void Function(DateTime)? onSelectedYear;
  final CalendarChooseYearStyle? calendarChooseYearStyle;

  @override
  State<CalendarChooseYear> createState() => _CalendarChooseYearState();
}

class _CalendarChooseYearState extends State<CalendarChooseYear> {
  late PageController _pageController;
  int startYear = 2000;
  int endYear = 2100;
  late int focusYear;

  @override
  void initState() {
    super.initState();
    startYear = widget.firstDay.year;
    endYear = widget.lastDay.year;
    focusYear = widget.focusedDay.year;
    int initialPage = (focusYear - widget.firstDay.year) ~/ 12;
    _pageController = PageController(initialPage: initialPage);
    widget.onPageYearControllerCreated.call(_pageController);
    startYear = widget.firstDay.year + (initialPage * 12);
    widget.onYearDifChange?.call(DateTime(startYear));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: ((endYear - widget.firstDay.year) ~/ 12) + 1,
      onPageChanged: (index) {
        startYear = widget.firstDay.year + (index * 12);
        widget.onYearDifChange?.call(DateTime(startYear));
      },
      itemBuilder: (context, index) {
        return _buildYearGrid(widget.firstDay.year + (index * 12));
      },
    );
  }

  Widget _buildYearGrid(int start) {
    return GridView.builder(
      padding: EdgeInsets.all(16),
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        int year = start + index;
        return GestureDetector(
          onTap: () {
            if (year > endYear) return;
            widget.onSelectedYear?.call(DateTime(year));
          },
          child: Container(
            decoration: year > endYear
                ? widget.calendarChooseYearStyle?.disableYearDecoration
                : focusYear == year
                    ? widget.calendarChooseYearStyle?.chooseYearDecoration
                    : widget.calendarChooseYearStyle?.unChooseYearDecoration,
            child: Center(
              child: Text(
                "$year",
                style: year > endYear
                    ? widget.calendarChooseYearStyle?.disableTextStyle
                    : focusYear == year
                        ? widget.calendarChooseYearStyle?.chooseTextStyle
                        : widget.calendarChooseYearStyle?.unChooseTextStyle,
              ),
            ),
          ),
        );
      },
    );
  }
}
