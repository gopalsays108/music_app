//How Async work
asyncTask() {
  print("Im first line");

  Future.delayed(Duration(seconds: 5), () {
    print("I will call after 5 seconds");

    Future.delayed(Duration(seconds: 3), () {
      print("Im inside with 4");

      Future.delayed(Duration(seconds: 3), () {
        print("Im inside with 3");

        Future.delayed(Duration(seconds: 3), () {
          print("Im inside with 2");

          Future.delayed(Duration(seconds: 3), () {
            print("Im inside with 1");
          });
        });
      });
    });
  }).then((value) {
    print("im then");
  });

  print("Im last line");
}

void main() {
  asyncTask();
}
