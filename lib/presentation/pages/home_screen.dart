import 'package:another_flushbar/flushbar_helper.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/store/form/form_store.dart';
import 'package:flutter_application_1/di/service_locator.dart';
import 'package:flutter_application_1/presentation/store/category_store.dart';
import 'package:flutter_application_1/presentation/store/home_store.dart';
import 'package:flutter_application_1/presentation/widgets/amount_input.dart';
import 'package:flutter_application_1/presentation/widgets/category.dart';
import 'package:flutter_application_1/presentation/widgets/date_selector.dart';
import 'package:flutter_application_1/presentation/widgets/description_input.dart';
import 'package:flutter_application_1/presentation/widgets/expense_tab_switch.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TransactionType _selectedType = TransactionType.income;
  int? _selectedCategoryId;
  DateTime _selectedDate = DateTime.now();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  final _categoryStore = getIt<CategoryStore>();
  final _formStore = getIt<FormStore>();
  final _homeStore = getIt<HomeStore>();

  Future<void> _submitTransaction() async {
    final amountText = _amountController.text.trim();
    final description = _noteController.text.trim();
    _formStore.validateAmount(amountText);
    final typeString =
        _selectedType == TransactionType.income ? 'tiền thu' : 'tiền chi';
    final createDate = _selectedDate;
    if (_selectedCategoryId == null) {
      print('Vui lòng chọn danh mục');
      return;
    }

    try {
      final amount = Decimal.parse(amountText);
      await _homeStore.createExp(
        amount,
        description,
        createDate,
        typeString,
        _selectedCategoryId!,
      );

    } catch (e) {
      print('Lỗi chuyển đổi số tiền: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpenseTabSwitch(
              selectedType: _selectedType,
              onChanged: (type) {
                setState(() => _selectedType = type);
                _categoryStore.setSelectedType(
                  type == TransactionType.income ? 'income' : 'expense',
                );
              },
            ),

            const SizedBox(height: 16),

            DateSelector(
              selectedDate: _selectedDate,
              onDateSelected: (date) {
                setState(() => _selectedDate = date);
              },
            ),

            const SizedBox(height: 16),

            Observer(
              builder:
                  (_) => AmountInput(
                    controller: _amountController,
                    errorText: _formStore.formErrorStore.amount,
                    onChanged: (value) {
                      _formStore.setAmount(value);
                      _formStore.validateAmount(value);
                    },
                  ),
            ),

            const SizedBox(height: 16),

            DescriptionInput(controller: _noteController),

            const SizedBox(height: 24),

            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 400),
              child: Category(
                store: _categoryStore,
                selectedType: _selectedType,
                onCategorySelected: (id) {
                  setState(() {
                    _selectedCategoryId = id;
                  });
                },
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitTransaction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                child: const Text('Lưu giao dịch'),
              ),
            ),
          ],
        ),
      ),
    );
  }

@override
void initState() {
  super.initState();
  // Lắng nghe trạng thái success
  reaction(
    (_) => _homeStore.success,
    (bool success) {
      if (success) {
        FlushbarHelper.createSuccess(
          message: "Tạo giao dịch thành công!",
          duration: Duration(seconds: 2),
        ).show(context);

        // Reset sau khi hiển thị
        Future.delayed(Duration(seconds: 2), () {
          _homeStore.resetSuccess();
        });

        // Reset form
        _amountController.clear();
        _noteController.clear();
        setState(() {
          _selectedDate = DateTime.now();
          _selectedType = TransactionType.income;
          _selectedCategoryId = null;
        });
        // Cập nhật type cho categoryStore nếu cần
        _categoryStore.setSelectedType("income");
      }
    },
  );

  // Reaction cho error message
  reaction(
    (_) => _homeStore.errorStore.errorMessage,
    (String message) {
      if (message.isNotEmpty) {
        FlushbarHelper.createError(
          message: message,
          duration: Duration(seconds: 3),
        ).show(context);
      }
    },
  );
}

  PreferredSizeWidget _buildAppBar() {
    return AppBar(actions: _buildActions(context));
  }


  List<Widget> _buildActions(BuildContext context) {
    return <Widget>[];
  }
}
