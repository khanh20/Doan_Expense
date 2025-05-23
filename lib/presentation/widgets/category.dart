import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/store/category_store.dart';
import 'package:flutter_application_1/presentation/widgets/expense_tab_switch.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class Category extends StatefulWidget {
  final CategoryStore store;
  final TransactionType selectedType;
  final Function(int categoryId)? onCategorySelected;

  const Category({
    super.key,
    required this.store,
    required this.selectedType,
    this.onCategorySelected,
  });
  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  int? _selectedCategoryId;
  @override
  void initState() {
    super.initState();
    widget.store.getCategory(); // Gọi API khi mở trang
  }

  @override
  Widget build(BuildContext context) {
    final store = widget.store;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Danh mục', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Observer(
        builder: (_) {
          final future = store.getCategoryFuture;

          if (future.status == FutureStatus.pending) {
            return const Center(child: CircularProgressIndicator());
          }

          if (future.status == FutureStatus.rejected) {
            return Center(
              child: Text(
                store.errorStore.errorMessage ?? 'Đã xảy ra lỗi',
                style: const TextStyle(color: Colors.white),
              ),
            );
          }

          final categories = future.value ?? [];
          final filteredCategories =
              categories
                  .where(
                    (c) =>
                        c?.type ==
                        (widget.selectedType == TransactionType.income
                            ? 'tiền thu'
                            : 'tiền chi'),
                  )
                  .toList();
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1,
              ),
              itemCount: filteredCategories.length,
              itemBuilder: (context, index) {
                final category = filteredCategories[index];
                final isSelected = category?.categoryId == _selectedCategoryId;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategoryId = category?.categoryId;
                    });
                    if (widget.onCategorySelected != null &&
                        category?.categoryId != null) {
                      widget.onCategorySelected!(category!.categoryId);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.grey[700] : Colors.grey[900],
                      borderRadius: BorderRadius.circular(12),
                      border:
                          isSelected
                              ? Border.all(color: Colors.white, width: 2)
                              : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            category?.name ?? '',
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,// vượt quá thì ...
                            textAlign: TextAlign.center,
                            softWrap: true,// xuống dòng
                          ),
                        ),

                        const SizedBox(height: 8),
                      ],
                    ),

                    // Text(
                    //   category?.type ?? '',
                    //   style: const TextStyle(color: Colors.white),
                    //   textAlign: TextAlign.center,
                    // ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
