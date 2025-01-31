class API {
  static String baseUrl = 'api.themoviedb.org';
  static const String apiKey = 'd2b9fff2c64df549c7232718ac2b77e3';
  static const String apiLanguage = 'es-ES';
  static const String apiAuth = '/api/auth';
  static const String movieCast = '/3/movie/{{movieId}}/credits';
  static const String popularMovies = '/3/movie/popular';
  static const String movieSearch = '/3/search/movie';
}
