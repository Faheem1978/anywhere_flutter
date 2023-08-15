import 'package:anywhere/core/enums/enums.dart';
import 'package:anywhere/core/viewmodel/items_list_view_model.dart';
import 'package:anywhere/view/items_detail.dart';
import 'package:anywhere/view/utils.dart';
import 'package:anywhere/view/widgets/split_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ItemsListView extends StatefulWidget {
  @override
  _ItemsListViewState createState() => _ItemsListViewState();
}

class _ItemsListViewState extends State<ItemsListView> {
  onViewModelReady(ItemListViewModel model) {
    model.getItemsList();
  }

  itemsList(ItemListViewModel model) {
    return model.state == ViewState.loading
        ? const Center(child: CircularProgressIndicator())
        : model.state == ViewState.error
            ? const Center(
                child: Text("Oops! Something went wrong!"),
              )
            : ListView.builder(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                itemCount: model.relatedTopics!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              model.relatedTopics![index].text!,
                            ),
                          ),
                          IconButton(
                              onPressed: () => context.isDesktop
                                  ? model.updateSelected(
                                      model.relatedTopics![index])
                                  : model
                                      .onPressed(model.relatedTopics![index]),
                              icon: const Icon(Icons.chevron_right)),
                        ],
                      ),
                      const Divider(),
                    ],
                  );
                },
              );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => ItemListViewModel(),
      onViewModelReady: (model) => onViewModelReady(model),
      builder: (context, ItemListViewModel model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(model.title),
          ),
          body: context.isDesktop
              ? SplitView(
                  panel: itemsList(model),
                  pageBody: model.selected == null
                      ? Container()
                      : ItemDetailView(model.selected!))
              : itemsList(model),
        );
      },
    );
  }
}
