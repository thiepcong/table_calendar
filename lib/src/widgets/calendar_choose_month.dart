import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../customization/calendar_choose_month_style.dart';

class CalendarChooseMonth extends StatefulWidget {
  const CalendarChooseMonth({
    super.key,
    required this.focusedDay,
    required this.firstDay,
    required this.lastDay,
    this.onYearChange,
    required this.onPageMonthControllerCreated,
    this.onSelectedMonth,
    this.calendarChooseMonthStyle,
    this.locale,
  });

  final DateTime focusedDay;
  final DateTime firstDay;
  final DateTime lastDay;
  final void Function(DateTime)? onYearChange;
  final void Function(PageController) onPageMonthControllerCreated;
  final void Function(DateTime)? onSelectedMonth;
  final CalendarChooseMonthStyle? calendarChooseMonthStyle;
  final dynamic locale;

  @override
  State<CalendarChooseMonth> createState() => _CalendarChooseMonthState();
}

class _CalendarChooseMonthState extends State<CalendarChooseMonth> {
  late PageController _pageController;
  int startYear = 2000;
  int endYear = 2100;
  late int focusYear;
  late int focusMonth;

  @override
  void initState() {
    super.initState();
    startYear = widget.firstDay.year;
    endYear = widget.lastDay.year;
    focusYear = widget.focusedDay.year;
    focusMonth = widget.focusedDay.month;
    int initialPage = focusYear - widget.firstDay.year;
    _pageController = PageController(initialPage: initialPage);
    widget.onPageMonthControllerCreated.call(_pageController);
    startYear = widget.firstDay.year + initialPage;
    widget.onYearChange?.call(DateTime(startYear, focusMonth));
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
      itemCount: endYear - widget.firstDay.year + 1,
      onPageChanged: (index) {
        startYear = widget.firstDay.year + index;
        widget.onYearChange?.call(DateTime(startYear));
      },
      itemBuilder: (context, index) {
        return _buildYearGrid(widget.firstDay.year + index);
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
        final month = DateTime(start, index + 1);
        return GestureDetector(
          onTap: () {
            if (month.isAfter(widget.lastDay) ||
                month.isBefore(widget.firstDay)) return;
            widget.onSelectedMonth?.call(month);
          },
          child: Container(
            decoration: month.isAfter(widget.lastDay) ||
                    month.isBefore(widget.firstDay)
                ? widget.calendarChooseMonthStyle?.disableMonthDecoration
                : focusYear == month.year && focusMonth == month.month
                    ? widget.calendarChooseMonthStyle?.chooseMonthDecoration
                    : widget.calendarChooseMonthStyle?.unChooseMonthDecoration,
            child: Center(
              child: Text(
                DateFormat.MMMM(widget.locale).format(month),
                style: month.isAfter(widget.lastDay) ||
                        month.isBefore(widget.firstDay)
                    ? widget.calendarChooseMonthStyle?.disableTextStyle
                    : focusYear == month.year && focusMonth == month.month
                        ? widget.calendarChooseMonthStyle?.chooseTextStyle
                        : widget.calendarChooseMonthStyle?.unChooseTextStyle,
              ),
            ),
          ),
        );
      },
    );
  }
}
