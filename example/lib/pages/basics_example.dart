// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../utils.dart';

class TableBasicsExample extends StatefulWidget {
  @override
  _TableBasicsExampleState createState() => _TableBasicsExampleState();
}

class _TableBasicsExampleState extends State<TableBasicsExample> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

// TableCalendar(
//           firstDay: widget.startDate ?? DateTime(1000),
//           lastDay: widget.endDate ?? DateTime.now(),
//           focusedDay: _focusedDay,
//           startingDayOfWeek: StartingDayOfWeek.monday,
//           headerStyle: HeaderStyle(
//             titleTextStyle:
//                 TextStyleApp.medium16.copyWith(color: context.colors.black),
//             formatButtonVisible: false,
//             titleCentered: true,
//             titleTextFormatter: (date, locale) => localeState.languageCode ==
//                     "vi"
//                 ? DateFormat.yMMMM(locale).format(date).capitalizeFirstLetter()
//                 : DateFormat.yMMMM(locale).format(date),
//           ),
//           daysOfWeekStyle: DaysOfWeekStyle(
//             weekdayStyle:
//                 TextStyleApp.regular14.copyWith(color: context.colors.black),
//             weekendStyle:
//                 TextStyleApp.regular14.copyWith(color: context.colors.black),
//             dowTextFormatter: (date, locale) {
//               List<String> shortWeekdays = [
//                 'CN',
//                 'T2',
//                 'T3',
//                 'T4',
//                 'T5',
//                 'T6',
//                 'T7',
//               ];
//               return localeState.languageCode == "vi"
//                   ? shortWeekdays[date.weekday % 7]
//                   : DateFormat.E(locale).format(date);
//             },
//           ),
//           daysOfWeekHeight: 36.h,
//           calendarStyle: CalendarStyle(
//             selectedTextStyle:
//                 TextStyleApp.regular14.copyWith(color: context.colors.white),
//             selectedDecoration: BoxDecoration(
//               borderRadius: BorderRadius.all(Radius.circular(8.r)),
//               color: context.colors.primary,
//             ),
//             todayDecoration: BoxDecoration(
//               color: context.colors.white,
//               border: Border.all(color: context.colors.primary),
//               borderRadius: BorderRadius.all(Radius.circular(8.r)),
//             ),
//             todayTextStyle:
//                 TextStyleApp.regular14.copyWith(color: context.colors.primary),
//             weekendTextStyle:
//                 TextStyleApp.regular14.copyWith(color: context.colors.black),
//             weekNumberTextStyle:
//                 TextStyleApp.regular14.copyWith(color: context.colors.black),
//             defaultTextStyle:
//                 TextStyleApp.regular14.copyWith(color: context.colors.black),
//           ),
//           selectedDayPredicate: (day) {
//             return isSameDay(_selectedDay, day);
//           },
//           onDaySelected: (selectedDay, focusedDay) {
//             setState(() {
//               _selectedDay = selectedDay;
//               _focusedDay = focusedDay;
//             });
//           },
//           onPageChanged: (focusedDay) {
//             setState(() {
//               _focusedDay = focusedDay;
//             });
//           },
//         )

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TableCalendar - Basics'),
      ),
      body: TableCalendar(
        firstDay: kFirstDay,
        lastDay: kLastDay,
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
        ),
        selectedDayPredicate: (day) {
          // Use `selectedDayPredicate` to determine which day is currently selected.
          // If this returns true, then `day` will be marked as selected.

          // Using `isSameDay` is recommended to disregard
          // the time-part of compared DateTime objects.
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            // Call `setState()` when updating the selected day
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          }
        },
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            // Call `setState()` when updating calendar format
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          // No need to call `setState()` here
          _focusedDay = focusedDay;
        },
      ),
    );
  }
}
