import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/company_review_model.dart';
import '../../data/viewmodels/review_vm.dart';

class CompanyReviewDetails extends StatefulWidget {
  final String company;
  const CompanyReviewDetails({super.key, required this.company});

  @override
  State<CompanyReviewDetails> createState() => _CompanyReviewDetailsState();
}

class _CompanyReviewDetailsState extends State<CompanyReviewDetails> {

  final ScrollController _scrollController = ScrollController();
  late Future<List<ReviewModel>> _reviews;

  @override
  void initState() {
    super.initState();
    _fetchReviews();
      if(mounted) {
        _scrollController.addListener(() {
          if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
            context.read<ReviewVm>().checkAndLoadMore(widget.company);
          }
        });
      }
  }

  void _fetchReviews() {
    setState(() {
      _reviews = context.read<ReviewVm>().getReviews(widget.company);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Company Review Details'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.read<ReviewVm>().currentPage = 1;
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Consumer<ReviewVm>(
            builder: (context, reviewVm, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FutureBuilder<List<ReviewModel>>(
                    future: _reviews,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator.adaptive());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if(snapshot.hasData) {
                        return Expanded(
                          child: ListView.separated(
                            controller: _scrollController,
                            itemCount: reviewVm.reviews.length + 1,
                            itemBuilder: (context, index) {
                              if(index < reviewVm.reviews.length) {
                                var company = reviewVm.reviews[index];
                                return ListTile(
                                  minTileHeight: 12,
                                  title: Text(company.reviewText ?? '', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),),
                                  subtitle: Text('Likes: ${company.reviewLikes}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.star, color: Colors.green, size: 12,),
                                      SizedBox(width: 3),
                                      Text(company.reviewRating.toString()),
                                    ],
                                  ),
                                  dense: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                  ),
                                );
                              } else {
                                return reviewVm.canLoadMore ? Center(child: CircularProgressIndicator.adaptive()) : SizedBox.shrink();
                              }
                            }, separatorBuilder: (BuildContext context, int index) { return SizedBox(height: 10); },
                          ),
                        );
                      } else {
                        return Center(child: Text('No reviews found'));
                      }
                    }
                  )

                ],
              );
            }
        ),
      ),
    );
  }
}
