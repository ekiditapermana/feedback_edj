import 'package:flutter/material.dart';
import 'package:mo_opendata_v2/helper/string_formatter.dart';
import 'package:mo_opendata_v2/model/feedback_model.dart';
import 'package:mo_opendata_v2/screen/dashboard_screen.dart';
import 'package:mo_opendata_v2/screen/detail_screen.dart';
import 'package:mo_opendata_v2/service/feedback_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<FeedbackModel> feedbackList = [];
  int limit = 25;
  int page = 1;
  bool isLoading = false;

  Future fetch() async {
    isLoading = true;
    final fs = FeedbackService();
    final newItems = await fs.getFeedbackList(limit: limit, page: page);
    setState(() {
      isLoading = false;
      feedbackList.addAll(newItems);
    });
  }

  Future refresh() async {
    setState(() {
      feedbackList.clear();
      page = 1;
      limit = 25;
      isLoading = false;
    });

    fetch();
  }

  @override
  void initState() {
    super.initState();

    fetch();
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
      itemBuilder: ((context, index) {
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
            subtitle: Text(feedbackList[index].sektor),
            trailing: _indicator(index));
      }),
      itemCount: feedbackList.length,
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
