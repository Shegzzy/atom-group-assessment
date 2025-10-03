import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/viewmodels/search_vm.dart';
import '../details_screen/company_details.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ScrollController scrollController = ScrollController();


  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        context.read<SearchCompanyVm>().checkAndLoadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Company Search'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Consumer<SearchCompanyVm>(
            builder: (context, searchCompanyVm, _) {
            return Column(
              children: [
                TextFormField(
                  controller: context.read<SearchCompanyVm>().searchController,
                  onFieldSubmitted: (value) => context.read<SearchCompanyVm>().onSearch(),
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Visibility(
                  visible: searchCompanyVm.isLoading,
                  child: Center(child: CircularProgressIndicator.adaptive())
                ),

                Visibility(
                  visible: !searchCompanyVm.isLoading,
                  child: Expanded(
                    child: ListView.separated(
                      controller: scrollController,
                      itemCount: searchCompanyVm.searchResults.length + 1,
                      itemBuilder: (context, index) {
                        if(index < searchCompanyVm.searchResults.length) {
                          var company = searchCompanyVm.searchResults[index];
                          return ListTile(
                            title: Text(company.name),
                            subtitle: Text('Reviews: ${company.reviewCount}'),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.star, color: Colors.green, size: 12,),
                                    SizedBox(width: 3),
                                    Text(company.rating.toString()),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    searchCompanyVm.toggleFavorite(company.companyId);
                                  },
                                  child: searchCompanyVm.favoriteIds.contains(company.companyId) ? Icon(Icons.favorite, size: 20, color: Colors.red,) : Icon(Icons.favorite_border, size: 20, color: Colors.grey,))
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
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => CompanyReviewDetails(company: company.website))
                              );
                            },
                          );
                        } else {
                          return searchCompanyVm.canLoadMore ? Center(child: CircularProgressIndicator.adaptive()) : SizedBox.shrink();
                        }
                      }, separatorBuilder: (BuildContext context, int index) { return SizedBox(height: 10); },
                    ),
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
