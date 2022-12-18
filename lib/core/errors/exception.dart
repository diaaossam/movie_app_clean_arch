import 'package:movie_app_clean_arch/core/network/error_message_model.dart';

class ServerException implements Exception{
  final ErrorMessageModel messageModel;
  const ServerException({required this.messageModel});
}

class OfflineException implements Exception{
  final String error;
  OfflineException({required this.error});
}


class EmptyCacheException implements Exception{
  final String error;
  EmptyCacheException({required this.error});
}