import 'package:riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecentSearchProvider extends StateNotifier<List<String>> {
  RecentSearchProvider() : super([]) {
    loadSearch();
  }
  loadSearch() async {
    final pref = await SharedPreferences.getInstance();
    final list = pref.getStringList('recent_search');
    state = list ?? [];
  }

  addSearch(String text) async {
    state = [text, ...state];
    if (state.length > 5) {
      state = state.sublist(0, 5);
    }
    final pref = await SharedPreferences.getInstance();
    await pref.setStringList('recent_search', state);
  }

  clearAll() async {
    state = [];
    final pref = await SharedPreferences.getInstance();
    await pref.setStringList('recent_search', state);
  }
}

final recentSearchProvider =
    StateNotifierProvider<RecentSearchProvider, List<String>>(
      (ref) => RecentSearchProvider(),
    );
