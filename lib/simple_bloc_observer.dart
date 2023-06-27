
import 'package:bloc/bloc.dart';

class SimpleBlocObserver extends BlocObserver {
 
  @override
  void onTransition(Bloc<dynamic,dynamic> bloc, Transition<dynamic,dynamic> transition) {
    super.onTransition(bloc, transition);
    print('${bloc.runtimeType} $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('${bloc.runtimeType} $error $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}