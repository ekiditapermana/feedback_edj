import 'package:flutter/material.dart';
import 'package:mo_opendata_v2/helper/string_formatter.dart';
import 'package:mo_opendata_v2/model/feedback_model.dart';
import 'package:mo_opendata_v2/screen/detail_screen.dart';
import 'package:mo_opendata_v2/service/feedback_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<FeedbackModel> feedbackList = [];
  int limit = 15;
  int page = 1;
  bool isLoading = false;
  bool hasMore = true;

  final scrollController = ScrollController();

  Future fetch() async {
    isLoading = true;
    final fs = FeedbackService();
    final newItems = await fs.getFeedbackList(limit: limit, page: page);

    setState(() {
      page++;

      isLoading = false;

      if (newItems.isEmpty) {
        hasMore = false;
      }

      feedbackList.addAll(newItems);
    });
  }

  Future refresh() async {
    setState(() {
      feedbackList.clear();
      page = 1;
      limit = 25;
      isLoading = false;
      hasMore = true;
    });

    fetch();
  }

  @override
  void initState() {
    super.initState();

    fetch();

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        fetch();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback List'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: refresh,
              child: _listview(),
            ),
    );
  }

  ListView _listview() {
    return ListView.builder(
      controller: scrollController,
      itemCount: feedbackList.length + 1,
      itemBuilder: ((context, index) {
        if (index < feedbackList.length) {
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) =>
                      DetailScreen(feedback: feedbackList[index])),
                ),
              );
            },
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(getAcronym(feedbackList[index].sektor)),
            ),
            title: Text(feedbackList[index].kontak),
            subtitle: feedbackList[index].saran.isNotEmpty
                ? Text(
                    feedbackList[index].saran,
                    overflow: TextOverflow.ellipsis,
                  )
                : const Text('Kolom saran dikosongkan'),
            trailing: _indicator(index),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(16),
          child: hasMore
              ? const Center(child: CircularProgressIndicator())
              : const Center(
                  child: Text(
                    'No more data to load',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
        );
      }),
    );
  }

  Row _indicator(int index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        feedbackList[index].catatanMO.isNotEmpty
            ? const Icon(
                Icons.text_snippet_rounded,
                color: Colors.green,
              )
            : const Icon(
                Icons.text_snippet_rounded,
              ),
        const SizedBox(
          width: 8,
        ),
        feedbackList[index].status
            ? const Icon(
                Icons.check_circle,
                color: Colors.green,
              )
            : const Icon(
                Icons.check_circle,
              ),
      ],
    );
  }
}
