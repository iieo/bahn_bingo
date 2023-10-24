import 'dart:async';

import 'package:boilerplate/domain/repository/post/post_repository.dart';
import 'package:boilerplate/domain/repository/game/game_repository.dart';
import 'package:boilerplate/domain/usecase/game/create_game_usecase.dart';
import 'package:boilerplate/domain/usecase/game/get_game_usecase.dart';
import 'package:boilerplate/domain/usecase/game/join_game_usecase.dart';
import 'package:boilerplate/domain/usecase/game/load_game_usecase.dart';
import 'package:boilerplate/domain/usecase/post/delete_post_usecase.dart';
import 'package:boilerplate/domain/usecase/post/find_post_by_id_usecase.dart';
import 'package:boilerplate/domain/usecase/post/get_post_usecase.dart';
import 'package:boilerplate/domain/usecase/post/insert_post_usecase.dart';
import 'package:boilerplate/domain/usecase/post/udpate_post_usecase.dart';

import '../../../di/service_locator.dart';

mixin UseCaseModule {
  static Future<void> configureUseCaseModuleInjection() async {
    // game:--------------------------------------------------------------------

    getIt.registerSingleton<GetGameUseCase>(
      GetGameUseCase(getIt<GameRepository>()),
    );

    getIt.registerSingleton<JoinGameUseCase>(
      JoinGameUseCase(getIt<GameRepository>()),
    );

    getIt.registerSingleton<CreateGameUseCase>(
      CreateGameUseCase(getIt<GameRepository>()),
    );

    getIt.registerSingleton<LoadGameUseCase>(
      LoadGameUseCase(getIt<GameRepository>()),
    );

    // post:--------------------------------------------------------------------
    getIt.registerSingleton<GetPostUseCase>(
      GetPostUseCase(getIt<PostRepository>()),
    );
    getIt.registerSingleton<FindPostByIdUseCase>(
      FindPostByIdUseCase(getIt<PostRepository>()),
    );
    getIt.registerSingleton<InsertPostUseCase>(
      InsertPostUseCase(getIt<PostRepository>()),
    );
    getIt.registerSingleton<UpdatePostUseCase>(
      UpdatePostUseCase(getIt<PostRepository>()),
    );
    getIt.registerSingleton<DeletePostUseCase>(
      DeletePostUseCase(getIt<PostRepository>()),
    );
  }
}
