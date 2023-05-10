import 'package:rxdart/rxdart.dart';

class AddCompositionSubscription{
  final composite = CompositeSubscription();


  void close(){
    composite.dispose();
  }
}