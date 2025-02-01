class RetryHelper {
  Future<T> retry<T>({
    required int maxRetries,
    required int delayMilliseconds,
    int retryCount = 0,
    required Future<T> Function() function,
  }) async {
    try {
      return await function();
    } catch (exception) {
      if (retryCount < maxRetries) {
        final nextCount = retryCount + 1;
        final retryInMilliseconds = delayMilliseconds * nextCount;
        await Future.delayed(Duration(milliseconds: retryInMilliseconds));
        return await retry(
          function: function,
          maxRetries: maxRetries,
          retryCount: nextCount,
          delayMilliseconds: delayMilliseconds,
        );
      } else {
        rethrow;
      }
    }
  }
}
