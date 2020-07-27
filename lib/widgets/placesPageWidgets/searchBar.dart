import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final ValueChanged<String> onValueChanged, onSubmit;
  final VoidCallback onTap;
  final TextEditingController searchController;
  final bool canSearch;

  SearchBar({
    @required this.onValueChanged,
    @required this.onSubmit,
    @required this.onTap,
    @required this.searchController,
    @required this.canSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 35,
      right: 20,
      left: 20,
      child: Container(
        height: 45.0,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.grey[400],
                offset: Offset(0.0, 5.0),
                blurRadius: 20.0,
                spreadRadius: 2.0)
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextFormField(
                onChanged: (value) {
                  onValueChanged(value);
                },
                onFieldSubmitted: (value) {
                  onSubmit(value);
                },
                style: TextStyle(height: 1.3),
                controller: searchController,
                cursorColor: Colors.black,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  suffixIcon: canSearch
                      ? InkWell(
                          onTap: onTap,
                          child: Container(
                            child: Icon(
                              Icons.search,
                              size: 20.0,
                              color: Colors.white,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.blue[400],
                                borderRadius: BorderRadius.circular(15.0)),
                          ),
                        )
                      : null,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black26),
                      borderRadius: BorderRadius.circular(15.0)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 1.0),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  contentPadding: EdgeInsets.only(left: 20.0),
                  hintText: "Search here",
                  hintStyle: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
