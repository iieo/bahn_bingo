import 'package:bahn_bingo/data/di/data_layer_injection.dart';
import 'package:bahn_bingo/domain/di/domain_layer_injection.dart';
import 'package:bahn_bingo/presentation/di/presentation_layer_injection.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

mixin ServiceLocator {
  static Future<void> configureDependencies() async {
    await DataLayerInjection.configureDataLayerInjection();
    await DomainLayerInjection.configureDomainLayerInjection();
    await PresentationLayerInjection.configurePresentationLayerInjection();
  }
}
