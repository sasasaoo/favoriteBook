import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite/entity/favorite.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AlbumDetailModel extends ChangeNotifier {
  List<Favorite> favorit = [];
  String favoriteId;
  FirebaseUser user;
  // String picDocumentId = '';
  bool isFavorite;

  changeFavorite() {
    if (isFavorite)
      isFavorite = false;
    else
      isFavorite = true;

    notifyListeners();
  }

  // お気に入り情報取得
  Future fetchFavorite(String picDocumentId) async {
    this.favorit = [];
    user = await FirebaseAuth.instance.currentUser();
    final docs = await Firestore.instance
        .collection('favorites')
        .where("userId", isEqualTo: user.uid)
        .where("picDocumentId", isEqualTo: picDocumentId)
        .limit(1)
        .getDocuments();
    this.favorit = docs.documents.map((doc) => Favorite(doc)).toList();
    if (favorit.length == 1) {
      isFavorite = true;
      favoriteId = this.favorit.first.documentId;
    } else {
      isFavorite = false;
    }
    notifyListeners();
  }

  // お気に入り追加
  Future saveFavorite(String picDocumentId, bool preIsFavorite) async {
    if (!preIsFavorite && isFavorite) {
      user = await FirebaseAuth.instance.currentUser();

      await Firestore.instance.collection('favorites').add(
        {
          'userId': user.uid,
          'picDocumentId': picDocumentId,
          'createdAt': Timestamp.now(),
        },
      );
    }
    if (preIsFavorite && !isFavorite) {
      await Firestore.instance
          .collection('favorites')
          .document(favoriteId)
          .delete();
    }
    notifyListeners();
  }
}
