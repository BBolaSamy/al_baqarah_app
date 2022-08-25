import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/pageControlBloc.dart';
import 'constant.dart';

class TextPageView extends StatefulWidget {
  const TextPageView({Key key}) : super(key: key);

  @override
  _TextPageViewState createState() => _TextPageViewState();
}

class _TextPageViewState extends State<TextPageView> {
  final GlobalKey pageKey = GlobalKey();
  final PageController _pageController = PageController();
  final TextStyle _textStyle = TextStyle(
    color: Colors.black,
    fontSize: 25,
    fontFamily: 'Kitab',
  );

  @override
  void initState() {
    super.initState();
    final controlBloc = BlocProvider.of<PageControlBloc>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controlBloc.getSizeFromBloc(pageKey);
      controlBloc.getSplittedTextFromBloc(_textStyle);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final controlBloc = BlocProvider.of<PageControlBloc>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.yellowAccent.withOpacity(0.2),
              key: pageKey,
              child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (val) {
                    controlBloc.changeState(val);
                  },
                  itemCount: controlBloc.splittedTextList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Center(
                        child: Text(
                          controlBloc.splittedTextList[index],
                          style: _textStyle,
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
