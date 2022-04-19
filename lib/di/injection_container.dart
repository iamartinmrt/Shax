import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:shax/data/datasources/remote/authentication/login/login_remote_datasource.dart';
import 'package:shax/data/datasources/remote/authentication/signup/signup_remote_datasource.dart';
import 'package:shax/data/datasources/remote/product/product_remote_datasource.dart';
import 'package:shax/data/datasources/remote/splash/splash_remote_datasource.dart';
import 'package:shax/data/repositories/login_repository_impl.dart';
import 'package:shax/data/repositories/product_repository_impl.dart';
import 'package:shax/data/repositories/signup_repository_impl.dart';
import 'package:shax/data/repositories/splash_repository_impl.dart';
import 'package:shax/di/dio_setting.dart';
import 'package:shax/domain/repositories/login_repository.dart';
import 'package:shax/domain/repositories/product_repository.dart';
import 'package:shax/domain/repositories/signup_repository.dart';
import 'package:shax/domain/repositories/splash_repository.dart';
import 'package:shax/domain/usecase/login_call_login_auth.dart';
import 'package:shax/domain/usecase/login_call_update_user.dart';
import 'package:shax/domain/usecase/product_call_create_product.dart';
import 'package:shax/domain/usecase/product_call_delete_product.dart';
import 'package:shax/domain/usecase/product_fetch_list_products.dart';
import 'package:shax/domain/usecase/signup_call_signup_auth.dart';
import 'package:shax/domain/usecase/splash_fetch_init_call.dart';
import 'package:shax/navigation/navigation_graph.dart';
import 'package:shax/navigation/route/app_route.dart';
import 'package:shax/presentation/bloc/authentication/login/bloc.dart';
import 'package:shax/presentation/bloc/authentication/signup/bloc.dart';
import 'package:shax/presentation/bloc/splash/splash_bloc.dart';

import '../models/entities/user.dart';


class InjectionContainer{

  static void register()async{
    _registerAppDependencies();
    _registerModules();
  }

  static void _registerModules(){
    DependencyProvider.registerSingleton(NavigationGraph());
    DependencyProvider.get<NavigationGraph>().registerFeature(AppRoute.routeMap);
    // CoreModuleInitializer.init();
  }

  static void _registerAppDependencies()async{

    //! External
    DependencyProvider.registerLazySingleton<ShaxLogger>(() => ShaxLogger());
    DependencyProvider.registerSingleton<Dio>(DioCustomSetting.createDio());


    // Data sources
    DependencyProvider.registerLazySingleton<SplashRemoteDatasource>(
          () => SplashRemoteDatasourceImpl(
            dio: DependencyProvider.get<Dio>(),
            logger: DependencyProvider.get<ShaxLogger>(),
          ));
    DependencyProvider.registerLazySingleton<LoginRemoteDatasource>(
            () => LoginRemoteDatasourceImpl(
          dio: DependencyProvider.get<Dio>(),
          logger: DependencyProvider.get<ShaxLogger>(),
        ));
    DependencyProvider.registerLazySingleton<SignupRemoteDatasource>(
            () => SignupRemoteDatasourceImpl(
          dio: DependencyProvider.get<Dio>(),
          logger: DependencyProvider.get<ShaxLogger>(),
        ));
    DependencyProvider.registerLazySingleton<ProductRemoteDatasource>(
            () => ProductRemoteDatasourceImpl(
          dio: DependencyProvider.get<Dio>(),
          logger: DependencyProvider.get<ShaxLogger>(),
        ));


    // Repository
    DependencyProvider.registerLazySingleton<SplashRepository>(
          () => SplashRepositoryImpl(
            datasource: DependencyProvider.get<SplashRemoteDatasource>(),
          ));
    DependencyProvider.registerLazySingleton<LoginRepository>(
            () => LoginRepositoryImpl(
              datasource: DependencyProvider.get<LoginRemoteDatasource>(),
            ));
    DependencyProvider.registerLazySingleton<SignupRepository>(
            () => SignupRepositoryImpl(
          datasource: DependencyProvider.get<SignupRemoteDatasource>(),
        ));
    DependencyProvider.registerLazySingleton<ProductRepository>(
            () => ProductRepositoryImpl(
          datasource: DependencyProvider.get<ProductRemoteDatasource>(),
        ));


    // Use cases
    DependencyProvider.registerLazySingleton<SplashFetchInitCall>(
            () => SplashFetchInitCall(
              repository: DependencyProvider.get<SplashRepository>(),
            ));
    DependencyProvider.registerLazySingleton<LoginCallLoginAuth>(
            () => LoginCallLoginAuth(
              repository: DependencyProvider.get<LoginRepository>(),
            ));
    DependencyProvider.registerLazySingleton<LoginCallUpdateUser>(
            () => LoginCallUpdateUser(
              repository: DependencyProvider.get<LoginRepository>(),
            ));
    DependencyProvider.registerLazySingleton<SignupCallSignupAuth>(
            () => SignupCallSignupAuth(
          repository: DependencyProvider.get<SignupRepository>(),
        ));
    DependencyProvider.registerLazySingleton<ProductCallCreateProduct>(
            () => ProductCallCreateProduct(
          repository: DependencyProvider.get<ProductRepository>(),
        ));
    DependencyProvider.registerLazySingleton<ProductCallDeleteProduct>(
            () => ProductCallDeleteProduct(
          repository: DependencyProvider.get<ProductRepository>(),
        ));
    DependencyProvider.registerLazySingleton<ProductFetchListProducts>(
            () => ProductFetchListProducts(
          repository: DependencyProvider.get<ProductRepository>(),
        ));


    // Bloc
    DependencyProvider.registerFactory<SplashBloc>(
            () => SplashBloc(
                fetchInitCall: DependencyProvider.get<SplashFetchInitCall>()
            ));
    DependencyProvider.registerFactory<LoginBloc>(
            () => LoginBloc(
              logger: DependencyProvider.get<ShaxLogger>(),
              hiveBox: DependencyProvider.get<Box<User>>(),
              callUpdateUser: DependencyProvider.get<LoginCallUpdateUser>(),
              callLoginAuth: DependencyProvider.get<LoginCallLoginAuth>(),
            ));
    DependencyProvider.registerFactory<SignupBloc>(
            () => SignupBloc(
              hiveBox: DependencyProvider.get<Box<User>>(),
              signupCallSignupAuth: DependencyProvider.get<SignupCallSignupAuth>(),
            ));


    // //! Core
    // sl.registerLazySingleton(() => RemoteStorage(getStorage: sl()));
  }

}
