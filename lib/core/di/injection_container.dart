import 'package:get_it/get_it.dart';

// Import các lớp của bạn
import 'package:neura/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:neura/feature/conversation/data/datasources/conversation_remote_data_source.dart';
import 'package:neura/feature/chat/data/datasources/message_remote_data_source.dart';
import 'package:neura/feature/contacts/data/datasources/contact_remote_data_source.dart';

import 'package:neura/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:neura/feature/conversation/data/repositories/conversation_repository_impl.dart';
import 'package:neura/feature/chat/data/repositories/message_repository_impl.dart';
import 'package:neura/feature/contacts/data/repositories/contact_repository_impl.dart';

import 'package:neura/feature/auth/domain/repositories/auth_repository.dart';
import 'package:neura/feature/conversation/domain/repositories/conversation_repository.dart';
import 'package:neura/feature/chat/domain/repositories/message_repository.dart';
import 'package:neura/feature/contacts/domain/repositories/contact_repository.dart';

import 'package:neura/feature/auth/domain/usecases/login_use_case.dart';
import 'package:neura/feature/auth/domain/usecases/register_use_case.dart';
import 'package:neura/feature/conversation/domain/usecases/fetch_conversation_use_case.dart';
import 'package:neura/feature/chat/domain/usecases/fetch_message_use_case.dart';
import 'package:neura/feature/contacts/domain/usecases/fetch_contact_use_case.dart';
import 'package:neura/feature/contacts/domain/usecases/add_contact_use_case.dart';
import 'package:neura/feature/conversation/domain/usecases/check_or_create_conversation_use_case.dart';

final sl = GetIt.instance; // sl = service locator

Future<void> initDependencies() async {
  // 🧩 DataSources
  sl.registerLazySingleton(() => AuthRemoteDataSource());
  sl.registerLazySingleton(() => ConversationRemoteDataSource());
  sl.registerLazySingleton(() => MessageRemoteDataSource());
  sl.registerLazySingleton(() => ContactRemoteDataSource());

  // 🏗️ Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authRemoteDataSource: sl()),
  );
  sl.registerLazySingleton<ConversationRepository>(
    () => ConversationRepositoryImpl(converSationRemoteDataDource: sl()),
  );
  sl.registerLazySingleton<MessageRepository>(
    () => MessageRepositoryImpl(messageRemoteDataSource: sl()),
  );
  sl.registerLazySingleton<ContactRepository>(
    () => ContactRepositoryImpl(contactRemoteDataSource: sl()),
  );

  // ⚙️ UseCases
  sl.registerLazySingleton(() => LoginUseCase(repository: sl()));
  sl.registerLazySingleton(() => RegisterUseCase(repository: sl()));
  sl.registerLazySingleton(() => FetchConversationsUseCase(repository: sl()));
  sl.registerLazySingleton(() => FetchMessageUseCase(repository: sl()));
  sl.registerLazySingleton(() => FetchContactUseCase(contactRepository: sl()));
  sl.registerLazySingleton(() => AddContactUseCase(contactRepository: sl()));
  sl.registerLazySingleton(
    () => CheckOrCreateConversationUseCase(conversationRepository: sl()),
  );
}
