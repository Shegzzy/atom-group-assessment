import 'package:atom_assessment/features/data/models/company_model.dart';
import 'package:atom_assessment/features/utils/app_logger.dart';
import 'package:flutter/cupertino.dart';

import '../../utils/app_snackbar.dart';
import '../repositories/search_repo.dart';

class SearchCompanyVm extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();

  ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;

  final _searchCompanyRepository = SearchCompanyRepository();
  List<CompanyModel> _searchResults = [];
  List<CompanyModel> get searchResults => _searchResults;

  int _currentPage = 1;
  int get currentPage => _currentPage;
  set currentPage(int value) {
    _currentPage = value;
    notifyListeners();
  }

  int _totalCompanies = 0;
  int get totalCompanies => _totalCompanies;
  set totalCompanies(int value) {
    _totalCompanies = value;
    notifyListeners();
  }


  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _canLoadMore = false;
  bool get canLoadMore => _canLoadMore;
  set canLoadMore(bool value) {
    _canLoadMore = value;
    notifyListeners();
  }



  Future<dynamic> getSearchResults(String query) async {
    isLoading = true;

    try {
      if (query.isEmpty) return;

      final response = await _searchCompanyRepository.getSearchResults(query, _currentPage);

      if (response == null) return [];

      int statusCode = response.statusCode;
      var payload = response.data;

      if (statusCode == 200) {
        var data = payload['data']['companies'];
        totalCompanies = payload['data']['total_companies'];

        _searchResults = data.map<CompanyModel>((company) => CompanyModel.fromJson(company)).toList();
        AppLogger.instance.logInfo(searchResults);
        return _searchResults;
      } else {
        showErrorBar (payload['message'] ?? 'Error occurred searching companies');
        return [];
      }
    } catch (e) {
      AppLogger.instance.logError(e);
      return [];
    } finally {
      isLoading = false;
      notifyListeners();
    }

  }

  void onSearch() {
    if (searchController.text.isNotEmpty) {
      getSearchResults(searchController.text);
    } else {
      _searchResults = [];
      notifyListeners();
    }
  }

  Future<dynamic> checkAndLoadMore() async {
    print('Checking for more');
    try {
      if (_searchResults.length < totalCompanies) {
        canLoadMore = true;
        notifyListeners();

        currentPage++;
        final response = await _searchCompanyRepository.getSearchResults(searchController.text.trim(), currentPage);

        if (response == null) return _searchResults;

        int statusCode = response.statusCode;
        var payload = response.data;

        if (statusCode == 200) {
          var data = payload['data']['companies'];

          _searchResults.addAll(data.map<CompanyModel>((company) => CompanyModel.fromJson(company)));
          AppLogger.instance.logInfo(searchResults);
          return _searchResults;
        } else {
          showErrorBar (payload['message'] ?? 'Error occurred searching companies');
          return _searchResults;
        }
      }
    } catch (e) {
      AppLogger.instance.logError(e);
    } finally {
      canLoadMore = false;
      notifyListeners();
    }
  }
}