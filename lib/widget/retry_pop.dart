import 'package:flutter/material.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:secondd_ui/pages/homepage.dart';
// import 'package:secondd_ui/service/movie_service.dart';

class RetryPop extends StatelessWidget {
  const RetryPop({super.key});

  // final MovieService fetchData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.wifi_off_rounded, size: 100, color: Colors.red),
                Text(
                  "Network error",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  "Failed to fetch data. Please check your internet connection and try again.",
                  style: TextStyle(fontSize: 12, color: Colors.grey),

                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Homepage();
                        },
                      ),
                    );
                  },

                  child: SizedBox(
                    width: double.infinity,
                    child: Text("Retry", textAlign: TextAlign.center),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      //  AlertDialog(
      //   title: const Text('Network Error'),
      //   content: Text(
      //     "Failed to fetch data. Please check your internet connection and try again.",
      //   ),
      //   actions: [
      //     TextButton(
      //       onPressed: () {
      //         Navigator.of(context).pop();
      //         // fetchData; // Retry
      //       },
      //       child: const Text('Retry'),
      //     ),
      //     TextButton(
      //       onPressed: () => Navigator.of(context).pop(),
      //       child: const Text('Cancel'),
      //     ),
      //   ],
      // ),
    );
  }
}
