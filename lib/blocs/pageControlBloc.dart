import 'package:al_baqarah_app/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/dyamicSize.dart';
import '../logic/splittedText.dart';

class PageControlBloc extends Cubit<int> {
  PageControlBloc() : super(0);

  DynamicSize _dynamicSize = DynamicSizeImpl();
  SplittedText _splittedText = SplittedTextImpl();
  Size _size;
  List<String> _splittedTextList = [];
  List<String> get splittedTextList => _splittedTextList;

  getSizeFromBloc(GlobalKey pagekey) {
    _size = _dynamicSize.getSize(pagekey);
    print(_size);
  }

  getSplittedTextFromBloc(TextStyle textStyle) {
    _splittedTextList =
        _splittedText.getSplittedText(_size, textStyle, kSmapleText);
  }

  void changeState(int currentIndex) {
    emit(currentIndex);
  }
}
