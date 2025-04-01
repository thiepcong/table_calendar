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
    this.isChooseQuaterOnly = false,
  });

  final DateTime focusedDay;
  final DateTime firstDay;
  final DateTime lastDay;
  final bool isChooseQuaterOnly;
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
    return widget.isChooseQuaterOnly
        ? ListView.builder(
            padding: EdgeInsets.all(16),
            physics: NeverScrollableScrollPhysics(),
            // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //   crossAxisCount: 1,
            //   childAspectRatio: 2,
            //   crossAxisSpacing: 10,
            //   mainAxisSpacing: 10,
            // ),
            itemCount: 4,
            itemBuilder: (context, index) {
              final month = DateTime(start, index * 3 + 1);
              final month2 = DateTime(start, index * 3 + 2);
              final month3 = DateTime(start, index * 3 + 3);
              final isDisable = month.isAfter(widget.lastDay) ||
                  month.isBefore(widget.firstDay) ||
                  month2.isAfter(widget.lastDay) ||
                  month2.isBefore(widget.firstDay) ||
                  month3.isAfter(widget.lastDay) ||
                  month3.isBefore(widget.firstDay);
              return GestureDetector(
                onTap: () {
                  if (isDisable) return;
                  widget.onSelectedMonth?.call(month);
                },
                child: Container(
                  decoration: isDisable
                      ? widget.calendarChooseMonthStyle?.disableMonthDecoration
                      : focusYear == month.year && focusMonth == month.month
                          ? widget
                              .calendarChooseMonthStyle?.chooseMonthDecoration
                          : widget.calendarChooseMonthStyle
                              ?.unChooseMonthDecoration,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      if (widget.calendarChooseMonthStyle?.prefixShowQuarter !=
                          null)
                        widget.calendarChooseMonthStyle!.prefixShowQuarter!(
                          index,
                          focusYear == month.year && focusMonth == month.month,
                        ),
                      Expanded(
                        child: Container(
                          decoration: month.isAfter(widget.lastDay) ||
                                  month.isBefore(widget.firstDay)
                              ? widget.calendarChooseMonthStyle
                                  ?.disableMonthDecoration
                              : focusYear == month.year &&
                                      focusMonth == month.month
                                  ? widget.calendarChooseMonthStyle
                                      ?.chooseMonthDecoration
                                  : widget.calendarChooseMonthStyle
                                      ?.unChooseMonthDecoration,
                          child: Center(
                            child: Text(
                              DateFormat.MMMM(widget.locale).format(month),
                              style: month.isAfter(widget.lastDay) ||
                                      month.isBefore(widget.firstDay)
                                  ? widget.calendarChooseMonthStyle
                                      ?.disableTextStyle
                                  : focusYear == month.year &&
                                          focusMonth == month.month
                                      ? widget.calendarChooseMonthStyle
                                          ?.chooseTextStyle
                                      : widget.calendarChooseMonthStyle
                                          ?.unChooseTextStyle,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: month2.isAfter(widget.lastDay) ||
                                  month2.isBefore(widget.firstDay)
                              ? widget.calendarChooseMonthStyle
                                  ?.disableMonthDecoration
                              : focusYear == month.year &&
                                      focusMonth == month.month
                                  ? widget.calendarChooseMonthStyle
                                      ?.chooseMonthDecoration
                                  : widget.calendarChooseMonthStyle
                                      ?.unChooseMonthDecoration,
                          child: Center(
                            child: Text(
                              DateFormat.MMMM(widget.locale).format(month2),
                              style: month2.isAfter(widget.lastDay) ||
                                      month2.isBefore(widget.firstDay)
                                  ? widget.calendarChooseMonthStyle
                                      ?.disableTextStyle
                                  : focusYear == month.year &&
                                          focusMonth == month.month
                                      ? widget.calendarChooseMonthStyle
                                          ?.chooseTextStyle
                                      : widget.calendarChooseMonthStyle
                                          ?.unChooseTextStyle,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: month3.isAfter(widget.lastDay) ||
                                  month3.isBefore(widget.firstDay)
                              ? widget.calendarChooseMonthStyle
                                  ?.disableMonthDecoration
                              : focusYear == month.year &&
                                      focusMonth == month.month
                                  ? widget.calendarChooseMonthStyle
                                      ?.chooseMonthDecoration
                                  : widget.calendarChooseMonthStyle
                                      ?.unChooseMonthDecoration,
                          child: Center(
                            child: Text(
                              DateFormat.MMMM(widget.locale).format(month3),
                              style: month3.isAfter(widget.lastDay) ||
                                      month3.isBefore(widget.firstDay)
                                  ? widget.calendarChooseMonthStyle
                                      ?.disableTextStyle
                                  : focusYear == month.year &&
                                          focusMonth == month.month
                                      ? widget.calendarChooseMonthStyle
                                          ?.chooseTextStyle
                                      : widget.calendarChooseMonthStyle
                                          ?.unChooseTextStyle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        : GridView.builder(
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
                          ? widget
                              .calendarChooseMonthStyle?.chooseMonthDecoration
                          : widget.calendarChooseMonthStyle
                              ?.unChooseMonthDecoration,
                  child: Center(
                    child: Text(
                      DateFormat.MMMM(widget.locale).format(month),
                      style: month.isAfter(widget.lastDay) ||
                              month.isBefore(widget.firstDay)
                          ? widget.calendarChooseMonthStyle?.disableTextStyle
                          : focusYear == month.year && focusMonth == month.month
                              ? widget.calendarChooseMonthStyle?.chooseTextStyle
                              : widget
                                  .calendarChooseMonthStyle?.unChooseTextStyle,
                    ),
                  ),
                ),
              );
            },
          );
  }
}
