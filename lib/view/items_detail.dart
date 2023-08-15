import 'package:anywhere/core/components/endpoints.dart';
import 'package:anywhere/core/model/item_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ItemDetailView extends StatelessWidget {
  ItemDetailView(this.selectedtopic);

  RelatedTopics selectedtopic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Column(
            children: [
              selectedtopic.icon!.uRL != null && selectedtopic.icon!.uRL != ''
                  ? CircleAvatar(
                      minRadius: 32,
                      backgroundColor: Colors.blue,
                      child: Image.network(
                          imageBaseUrl + selectedtopic.icon!.uRL!))
                  : Container(),
              const SizedBox(
                height: 16,
              ),
              Text(selectedtopic.text!),
              const SizedBox(
                height: 16,
              ),
              Text(selectedtopic.result!),
            ],
          ),
        ),
      ),
    );
  }
}
