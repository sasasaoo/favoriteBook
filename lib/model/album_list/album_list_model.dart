import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite/entity/picture.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AlbumListModel extends ChangeNotifier {
  List<Picture> pictures = [];
  int selectAlbumNo = 0;
  bool isLoading = false;
  bool isSideMenuOpen = false;

  startLoading() {
    isLoading = true;
    notifyListeners();
  }

  endLoading() {
    isLoading = false;
    notifyListeners();
  }

  changeAlbumNo(int albumNo) {
    selectAlbumNo = albumNo;
    notifyListeners();
  }

  sideMenuOpenClose() {
    isSideMenuOpen = isSideMenuOpen ? false : true;
    notifyListeners();
  }

  // 最新写真一覧取得
  void getNewPicture() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    // 最新10件分取得
    final snapshots = Firestore.instance
        .collection('albums/' + user.uid + '/album')
        .orderBy('createdAt', descending: true)
        .limit(10)
        .snapshots();
    snapshots.listen(
      (snapshot) {
        final pictures = snapshot.documents.map((doc) => Picture(doc)).toList();
        this.pictures = pictures;
        notifyListeners();
      },
    );
  }

  // アルバムNOで写真一覧取得
  void getAlbumNoPicture() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    final snapshots = Firestore.instance
        .collection('albums/' + user.uid + '/album')
        .where('albumNo', isEqualTo: selectAlbumNo)
        .orderBy('createdAt', descending: true)
        .snapshots();
    snapshots.listen(
      (snapshot) {
        final pictures = snapshot.documents.map((doc) => Picture(doc)).toList();
        this.pictures = pictures;
        notifyListeners();
      },
    );
  }

  // 本の削除
  Future deleteBook(Picture book) async {
    await Firestore.instance
        .collection('books')
        .document(book.documentId)
        .delete();
  }

  // カテゴリーカラーをセット
  Color setCategoryColor(int categoryId) {
    switch (categoryId) {
      case 0:
        return Colors.red[600];
      case 1:
        return Colors.pink[600];
      case 2:
        return Colors.blue;
      case 3:
        return Colors.green;
      case 4:
        return Colors.purple[500];
      default:
        return Colors.red[700];
    }
  }
}
