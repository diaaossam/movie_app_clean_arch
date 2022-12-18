class EndPoints{
  static const String _baseUrl = 'https://api.themoviedb.org/3';
  static const String _apiKey = "d736fa258d5b740a44ef20609bcc514a";
  static const String nowPlaying= "$_baseUrl/movie/now_playing?api_key=$_apiKey";
  static const String popularMovies= "$_baseUrl/movie/popular?api_key=$_apiKey";
  static const String topRatedMovies= "https://api.themoviedb.org/3/movie/top_rated?api_key=d736fa258d5b740a44ef20609bcc514a";
}

