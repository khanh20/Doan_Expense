import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/store/error/error_store.dart';
import 'package:flutter_application_1/core/store/form/form_store.dart';
import 'package:flutter_application_1/di/service_locator.dart';
import 'package:flutter_application_1/domain/entities/Statistic.dart';
import 'package:flutter_application_1/domain/usecases/expense/statistic_usecase.dart';
import 'package:flutter_application_1/presentation/store/statistic_store.dart';
import 'package:flutter_application_1/presentation/widgets/chart_widget.dart';
import 'package:flutter_application_1/presentation/widgets/date_selector.dart';
import 'package:flutter_application_1/presentation/widgets/finance_widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class StatisticalScreen extends StatefulWidget {
  @override
  State<StatisticalScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticalScreen> {
  late StatisticStore _statisticStore;
  DateTime _selectedDate = DateTime.now();
  String _selectedType = "day";

  @override
  void initState() {
    super.initState();
    _statisticStore = StatisticStore(
      getIt<StatisticUsecase>(),
      ErrorStore(),
      FormErrorStore(),
    );

    _statisticStore.statistic(_selectedDate);
  }

  Decimal _getIncome(Statistic s) {
    switch (_selectedType) {
      case "month":
        return s.monthIncome;
      case "year":
        return s.yearIncome;
      case "day":
      default:
        return s.dayIncome;
    }
  }

  Decimal _getExpense(Statistic s) {
    switch (_selectedType) {
      case "month":
        return s.monthExpense;
      case "year":
        return s.yearExpense;
      case "day":
      default:
        return s.dayExpense;
    }
  }

  Decimal _getRemaining(Statistic s) {
    switch (_selectedType) {
      case "month":
        return s.monthRemaining;
      case "year":
        return s.yearRemaining;
      case "day":
      default:
        return s.dayRemaining;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Thống kê"),centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DateSelector(
              selectedDate: _selectedDate,
              onDateSelected: (date) {
                setState(() {
                  _selectedDate = date;
                  _statisticStore.statistic(date);
                });
              },
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text("Thống kê theo: "),
                const SizedBox(width: 16),
                DropdownButton<String>(
                  value: _selectedType,
                  items: const [
                    DropdownMenuItem(value: "day", child: Text("Ngày")),
                    DropdownMenuItem(value: "month", child: Text("Tháng")),
                    DropdownMenuItem(value: "year", child: Text("Năm")),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedType = value;
                      });
                    }
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Observer(
                builder: (_) {
                  final future = _statisticStore.statisticFuture;
                  if (future == null || future.status == FutureStatus.pending) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (future.status == FutureStatus.rejected) {
                    return Text(
                      "Lỗi: ${_statisticStore.errorStore.errorMessage}",
                      style: const TextStyle(color: Colors.red),
                    );
                  } else if (future.status == FutureStatus.fulfilled) {
                    final statistic = future.value;
                    if (statistic == null)
                      return const Text("Không có dữ liệu.");
                    return Column(
                      children: [
                        FinanceWidget(
                          income: _getIncome(statistic),
                          expense: _getExpense(statistic),
                          remaining: _getRemaining(statistic),
                        ),
                        const SizedBox(height: 20),
                        ChartWidget(
                          income: _getIncome(statistic),
                          expense: _getExpense(statistic),
                        ),
                      ],
                    );
                  }

                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
