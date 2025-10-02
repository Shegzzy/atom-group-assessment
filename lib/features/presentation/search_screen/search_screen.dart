import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/company_model.dart';
import '../../data/viewmodels/search_vm.dart';

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
    context.read<SearchCompanyVm>().scrollController.addListener(() {
      if (context.read<SearchCompanyVm>().scrollController.position.pixels == context.read<SearchCompanyVm>().scrollController.position.maxScrollExtent) {
        context.read<SearchCompanyVm>().checkAndLoadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Company Search'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Consumer<SearchCompanyVm>(
            builder: (context, searchCompanyVm, _) {
            return Column(
              children: [
                TextField(
                  controller: context.read<SearchCompanyVm>().searchController,
                  onSubmitted: (value) => context.read<SearchCompanyVm>().onSearch(),
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
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
                      controller: searchCompanyVm.scrollController,
                      itemCount: searchCompanyVm.searchResults.length + 1,
                      itemBuilder: (context, index) {
                        if(index < searchCompanyVm.searchResults.length) {
                          var company = searchCompanyVm.searchResults[index];
                          return ListTile(
                            title: Text(company.name),
                            subtitle: Text('Reviews: ${company.reviewCount}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.star, color: Colors.green, size: 12,),
                                SizedBox(width: 3),
                                Text(company.rating.toString()),
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
