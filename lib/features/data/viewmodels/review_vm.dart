import 'package:flutter/cupertino.dart';

import '../../utils/app_logger.dart';
import '../../utils/app_snackbar.dart';
import '../models/company_review_model.dart';
import '../repositories/review_repo.dart';

class ReviewVm extends ChangeNotifier {
  ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;

  final _reviewRepository = ReviewRepository();
  List<ReviewModel> _reviews = [];
  List<ReviewModel> get reviews => _reviews;

  int _currentPage = 1;
  int get currentPage => _currentPage;
  set currentPage(int value) {
    _currentPage = value;
    notifyListeners();
  }

  int _totalReviews = 0;
  int get totalReviews => _totalReviews;
  set totalReviews(int value) {
    _totalReviews = value;
    notifyListeners();
  }

  bool _canLoadMore = false;
  bool get canLoadMore => _canLoadMore;
  set canLoadMore(bool value) {
    _canLoadMore = value;
    notifyListeners();
  }



  Future<List<ReviewModel>> getReviews(String query) async {
    try {
      if (query.isEmpty) {
        return _reviews;
      }

      final response = await _reviewRepository.getCompanyReviews(query, _currentPage);

      if (response == null) return [];

      int statusCode = response.statusCode;
      var payload = response.data;

      if (statusCode == 200) {
        var data = payload['data']['reviews'];
        totalReviews = payload['data']['total_reviews'];

        _reviews = data.map<ReviewModel>((company) => ReviewModel.fromJson(company)).toList();
        AppLogger.instance.logInfo(_reviews);
        return _reviews;
      } else {
        showErrorBar (payload['message'] ?? 'Error occurred fetching reviews for company');
        return [];
      }
    } catch (e) {
      AppLogger.instance.logError(e);
      return [];
    }

  }

  Future<dynamic> checkAndLoadMore(String query) async {
    try {
      if (_reviews.length < totalReviews) {
        canLoadMore = true;
        notifyListeners();

        currentPage++;
        final response = await _reviewRepository.getCompanyReviews(query, currentPage);

        if (response == null) return _reviews;

        int statusCode = response.statusCode;
        var payload = response.data;

        if (statusCode == 200) {
          var data = payload['data']['reviews'];

          _reviews.addAll(data.map<ReviewModel>((company) => ReviewModel.fromJson(company)));
          AppLogger.instance.logInfo(_reviews);
          return _reviews;
        } else {
          showErrorBar (payload['message'] ?? 'Error occurred loading more reviews');
          return _reviews;
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