import 'package:flutter/material.dart';
import '../../screens/customDialogBox.dart';

class SearchBar extends StatelessWidget {
  final ValueChanged<String> onValueChanged, onSubmit;
  final VoidCallback onTap;
  final TextEditingController searchController;
  final bool canSearch;
  final String userName, userEmail, userImage, pageName;

  SearchBar({
    @required this.onValueChanged,
    @required this.onSubmit,
    @required this.onTap,
    @required this.searchController,
    @required this.canSearch,
    @required this.userEmail,
    @required this.userName,
    @required this.userImage,
    @required this.pageName,
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
                offset: Offset(0.0, 10.0),
                blurRadius: 5.0,
                spreadRadius: 1.0)
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
                      ? Padding(
                          padding: EdgeInsets.all(4.0),
                          child: InkWell(
                            onTap: onTap,
                            child: Container(
                              child: Icon(
                                Icons.search,
                                size: 20.0,
                                color: Colors.white,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue[400],
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            showDialog(
                                builder: (context) => CustomDialogBox(
                                      userEmail: userEmail,
                                      userName: userName,
                                      userImage: userImage,
                                    ),
                                context: context);
                          },
                          child: (userImage != null)
                              ? Padding(
                                  padding: EdgeInsets.all(7.0),
                                  child: CircleAvatar(
                                    radius: 10.0,
                                    backgroundImage: NetworkImage(
                                        'http://10.0.2.2/TourMendWebServices/Images/profileImages/$userImage'),
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 10.0,
                                    backgroundColor: Colors.blue,
                                  ),
                                ),
                        ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black26),
                      borderRadius: BorderRadius.circular(15.0)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 1.0),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  contentPadding: EdgeInsets.only(left: 20.0),
                  hintText: "Search $pageName here..",
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
