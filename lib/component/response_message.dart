import 'package:flutter/material.dart';
import 'package:mo_opendata_v2/screen/home_screen.dart';

class ResponseMessage extends StatelessWidget {
  final String message;
  const ResponseMessage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            Text(message),
            SizedBox(
              height: 40,
              width: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                      (route) => false);
                },
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
