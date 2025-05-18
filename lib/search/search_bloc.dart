import 'package:expense_tracker/search/search_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ExpenseEvent {}

class ExpenseSearchQueryCharged extends ExpenseEvent {
  final String query;
  ExpenseSearchQueryCharged(this.query);
}

class ExpenseState {
  final List<Expense> filteredExpenses;
  ExpenseState(this.filteredExpenses);
}

class ExpenseAdded extends ExpenseEvent {
  final Expense expense;
  ExpenseAdded(this.expense);
}

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  List<Expense> allExpenses = [];

  ExpenseBloc() : super(ExpenseState([])) {
    on<ExpenseSearchQueryCharged>((event, emit) {
      final query = event.query.toLowerCase();
      final filtered =
          allExpenses
              .where((expense) => expense.number.contains(query))
              .toList();
      emit(ExpenseState(filtered));
    });

    on<ExpenseAdded>((event, emit) {
      allExpenses.add(event.expense);
      emit(ExpenseState(List.from(allExpenses)));
    });
  }
}
