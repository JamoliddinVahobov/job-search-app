import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_search_app/config/http_client_config.dart';

final dioProvider = Provider<Dio>((_) => createDio());
