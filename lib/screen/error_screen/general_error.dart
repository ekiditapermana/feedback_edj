import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GeneralError extends StatelessWidget {
  const GeneralError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 96,
            ),
            Image.asset('assets/animation_error.gif'),
            const SizedBox(
              height: 32,
            ),
            const Text(
              'Oopps! Terjadi Kesalahan',
              style: TextStyle(fontSize: 28),
            ),
            const Spacer(),
            SizedBox(
              height: 48,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text('Close'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
