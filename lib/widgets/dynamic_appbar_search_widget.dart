import 'package:flutter/material.dart';
import 'package:royalcruiser/constants/common_constance.dart';


class DynamicAppbarForSearchingWidget extends StatefulWidget {
  Function onClear;
  Function onTextSearching;
  String labelName;

  DynamicAppbarForSearchingWidget({
    required this.onClear,
    required this.onTextSearching,
    this.labelName = 'Select Company'
  });

  @override
  _DynamicAppbarForSearchingWidgetState createState() =>
      _DynamicAppbarForSearchingWidgetState();
}

class _DynamicAppbarForSearchingWidgetState
    extends State<DynamicAppbarForSearchingWidget> {
  bool _isDefaultAppbar = false;
  bool _isClear = false;
  final _focusNodeSearchStories = FocusNode();
  final _searchQueryTextEditingController = TextEditingController();

  Widget buildAppBar() {
    Widget appbar = AppBar(
      elevation: 0.0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Text(
        widget.labelName,
        style: TextStyle(
          fontSize: 18,
          letterSpacing: 0.5,
          fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_BOLD,
        ),
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            setState(() {
              _isDefaultAppbar = !_isDefaultAppbar;
            });
          },
          icon: const Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
      ],
    );

    if (!_isDefaultAppbar) {
      appbar = AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            widget.onClear();
            _searchQueryTextEditingController.text = "";
            FocusScope.of(context).requestFocus(_focusNodeSearchStories);
            setState(() {
              _isDefaultAppbar = !_isDefaultAppbar;
            });
          },
        ),
        title: TextField(
          autofocus: true,
          controller: _searchQueryTextEditingController,
          style: TextStyle(
            color: Colors.white70,
            letterSpacing: 1.5,
          ),
          onChanged: (text)
          {
            setState(() {
              widget.onClear();
              widget.onTextSearching(text);
            });
          },
           focusNode: _focusNodeSearchStories,
          cursorColor: Colors.white70,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
            hintStyle: TextStyle(
              color: Colors.white,
              letterSpacing: 1.5,
            ),
          ),
        ),
        actions: [
          if (_isClear)
            IconButton(
              onPressed: () {
                widget.onClear();
                _searchQueryTextEditingController.text = "";
              },
              icon: const Icon(
                Icons.clear,
                color: Colors.white70,
              ),
            ),
        ],
      );
    }

    return appbar;
  }

  @override
  void initState() {
    _searchQueryTextEditingController.addListener(() {
      if (_searchQueryTextEditingController.text.isNotEmpty) {
        setState(() {
          _isClear = true;
        });
      } else {
        setState(() {
          _isClear = false;
        });
      }
      widget.onTextSearching(_searchQueryTextEditingController.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    _focusNodeSearchStories.dispose();
    _searchQueryTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildAppBar();
  }
}
