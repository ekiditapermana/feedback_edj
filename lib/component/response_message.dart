import 'package:flutter/material.dart';
import 'package:mo_opendata_v2/screen/home_screen.dart';

class ResponseMessage extends StatelessWidget {
  final bool isOk;
  final String message;
  const ResponseMessage({
    Key? key,
    required this.message,
    required this.isOk,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 340,
          height: 230,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isOk
                  ? responseIcon(icon: Icons.check_circle, color: Colors.green)
                  : responseIcon(icon: Icons.error, color: Colors.red),
              const SizedBox(
                height: 20,
              ),
              Text(
                message,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 32,
                width: 90,
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
      ),
    );
  }

  Icon responseIcon({required IconData icon, required Color color}) {
    return Icon(
      icon,
      size: 60,
      color: color,
    );
  }
}
