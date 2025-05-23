import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/color_base.dart';
import 'package:flutter_application_1/core/store/error/error_store.dart';
import 'package:flutter_application_1/core/store/form/form_store.dart';
import 'package:flutter_application_1/di/service_locator.dart';
import 'package:flutter_application_1/domain/entities/Expense.dart';
import 'package:flutter_application_1/domain/usecases/expense/get_exp_usecase.dart';
import 'package:flutter_application_1/domain/usecases/expense/statistic_usecase.dart';
import 'package:flutter_application_1/presentation/store/get_exp_store.dart';
import 'package:flutter_application_1/presentation/store/statistic_store.dart';
import 'package:flutter_application_1/presentation/widgets/income_expense_widget.dart';
import 'package:flutter_application_1/utils/device/format.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late StatisticStore _statisticStore;
  late GetExpStore _getExpStore;

  @override
  void initState() {
    super.initState();
    _statisticStore = StatisticStore(
      getIt<StatisticUsecase>(),
      ErrorStore(),
      FormErrorStore(),
    );
    _getExpStore = GetExpStore(
      getIt<GetExpUsecase>(),
      ErrorStore(),
      FormErrorStore(),
    );
    _statisticStore.statistic(_focusedDay);
    _getExpStore.getExp(_focusedDay.toIso8601String());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lịch'),centerTitle: true,),
      body: Column(
        children: [
          TableCalendar(
            locale: 'vi_VN',
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: CalendarFormat.month,
            startingDayOfWeek: StartingDayOfWeek.monday,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.deepOrangeAccent,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.amber,
                shape: BoxShape.circle,
              ),
              weekendTextStyle: TextStyle(color: Colors.red),
              outsideDaysVisible: false,
            ),
            headerStyle: HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
            ),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
              _statisticStore.statistic(selectedDay);
              _getExpStore.getExp(selectedDay.toIso8601String());
            },
          ),

          Divider(),
          Observer(
            builder: (_) {
              final statistic =
                  _statisticStore.statisticFuture.status ==
                          FutureStatus.fulfilled
                      ? _statisticStore.statisticFuture.value
                      : null;
              final dayIncome = statistic?.dayIncome.toDouble().round() ?? 0;
              final dayExpense = statistic?.dayExpense.toDouble().round() ?? 0;
              final dayRemaining =
                  statistic?.dayRemaining.toDouble().round() ?? 0;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IncomeExpenseWidget(
                      label: 'Thu nhập',
                      amount: dayIncome,
                      color: ColorBase.primaryColor,
                    ),
                    IncomeExpenseWidget(
                      label: 'Chi tiêu',
                      amount: dayExpense,
                      color: ColorBase.secondaryColor,
                    ),
                    IncomeExpenseWidget(
                      label: 'Tổng',
                      amount: dayRemaining,
                      color: ColorBase.thirdColor,
                    ),
                  ],
                ),
              );
              
            },
          ),
          // Phần hiển thị danh sách chi tiêu trong ngày
          Expanded(
            child: Observer(
              builder: (_) {
                final expenses =
                    _getExpStore.getExpFuture.status == FutureStatus.fulfilled
                        ? (_getExpStore.getExpFuture.value as List)
                        : <dynamic>[];

                if (expenses.isEmpty) {
                  return Center(
                    child: Text('Không có chi tiêu trong ngày này'),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount: expenses.length,
                  itemBuilder: (context, index) {
                    Expense expense = expenses[index];
                    return ListTile(
                      title: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: expense.type,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color:
                                    expense.type == 'tiền thu'
                                        ? ColorBase.primaryColor
                                        : ColorBase.secondaryColor,
                              ),
                            ),
                            if (expense.description != null &&
                                expense.description!.isNotEmpty)
                              TextSpan(
                                text: '  (${expense.description})',
                                style: TextStyle(
                                  fontSize: 14,
                                  color:
                                      Colors.grey, 
                                ),
                              ),
                          ],
                        ),
                      ),

                      trailing: Text(
                         '${formatNumber(expense.amount ?? Decimal.zero)} đ',
                        style: TextStyle(
                          fontSize: 16,
                          color:
                              expense.type == 'tiền thu'
                                  ? ColorBase.primaryColor
                                  : ColorBase.secondaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


