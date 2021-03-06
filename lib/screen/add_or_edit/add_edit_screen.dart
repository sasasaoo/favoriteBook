import 'package:favorite/model/picture.dart';
import 'package:favorite/viewmodel/add_or_edit/add_or_edit_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/body.dart';

class AddEditScreen extends StatelessWidget {
  AddEditScreen({this.picture});
  final Picture? picture;
  // final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AddOrEditModel addOrEditModel =
        Provider.of<AddOrEditModel>(context, listen: false);
    final bool isUpdate = picture != null;

    if (isUpdate) {
      addOrEditModel.imageUrl = picture!.imageUrl;
    }

    return WillPopScope(
      onWillPop: () {
        addOrEditModel.initField();
        return Future.value(true);
      },
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                isUpdate ? '写真を編集' : '写真を追加',
              ),
            ),
            body: Body(
              picture: picture,
            ),
          ),
          // ローディングアニメーション
          addOrEditModel.isUploading
              ? Container(
                  color: Colors.grey.withOpacity(0.7),
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
