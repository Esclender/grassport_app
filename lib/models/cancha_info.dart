import 'package:google_maps_flutter/google_maps_flutter.dart';

class CanchaInfo {
  LatLng location;
  String nombre;
  String placeId;
  String description;
  String? ownerName;
  int rating;
  String address;
  bool isOpen;
  String photoURL;
  String ownerURL;
  List<Comment> comments;

  CanchaInfo({
    required this.nombre,
    required this.address,
    required this.placeId,
    required this.isOpen,
    required this.location,
    required this.comments,
    this.rating = 0,
    this.photoURL = '',
    this.ownerURL = '',
    this.description = '',
    this.ownerName,
  });

  Map getObjectForFavorites() {
    return {
      "location": {
        "latitude": location.latitude,
        "longitude": location.longitude
      },
      "locality": nombre,
      "street": address,
      "place_id": placeId,
    };
  }

  // static List<CanchaInfo> transformResponse(body) {
  //   List<CanchaInfo> canchas = [];

  //   for (Map cancha in body['response']) {
  //     CanchaInfo canchaInfo = CanchaInfo(
  //       nombre: cancha['name'],
  //       photoURL: cancha['photoURL'],
  //       address: cancha['address'],
  //       placeId: cancha['place_id'],
  //       rating: cancha['rating'] ?? 0,
  //       isOpen: cancha['isOpen'] ?? false,
  //       location: LatLng(
  //           cancha['location']['latitude'], cancha['location']['longitude']),
  //     );
  //     canchas.add(canchaInfo);
  //   }

  //   return canchas;
  // }

  static CanchaInfo transformResponseDetails(body) {
    Map data = body['response'];

    return CanchaInfo(
      nombre: data['name'],
      photoURL: data['photoURL'],
      ownerURL: data['userURL'],
      address: data['address'],
      placeId: data['place_id'],
      ownerName: data['ownerName'],
      rating: data['rating'] ?? 0,
      description: data['description'] ?? '',
      isOpen: data['isOpen'] ?? false,
      location: LatLng(
        data['location']['latitude'],
        data['location']['longitude'],
      ),
      comments: Comment.transformCanchaComments(data['comments']),
    );
  }

  static List<CanchaInfo> transformResponseInCanchas(body) {
    List<CanchaInfo> canchas = [];

    for (Map cancha in body['response']) {
      CanchaInfo canchaInfo = CanchaInfo(
        nombre: cancha['locality'],
        placeId: cancha['place_id'],
        address: cancha['street'],
        isOpen: true,
        location: LatLng(
          cancha['location']['latitude'],
          cancha['location']['longitude'],
        ),
        comments: [],
      );
      canchas.add(canchaInfo);
    }

    return canchas;
  }
}

class CanchaMarker {
  LatLng location;
  String nombre;
  String placeId;
  int? rating;
  String address;
  String? photoURL;

  CanchaMarker({
    required this.nombre,
    required this.placeId,
    required this.location,
    required this.address,
    this.rating,
    this.photoURL,
  });

  static List<CanchaMarker> transformResponse(body) {
    List<CanchaMarker> canchas = [];

    for (Map cancha in body['response']) {
      CanchaMarker canchaInfo = CanchaMarker(
        nombre: cancha['name'],
        placeId: cancha['place_id'],
        rating: cancha['rating'],
        address: cancha['address'],
        photoURL: cancha['photoURL'],
        location: LatLng(
          cancha['location']['latitude'],
          cancha['location']['longitude'],
        ),
      );
      canchas.add(canchaInfo);
    }

    return canchas;
  }
}

class Comment {
  final String name;
  final String comment;
  final String profilePicture;
  final List<Comment> replies;
  final bool isOwner;
  final String tiempoPublicado;
  final String id;
  final String placeId;

  Comment({
    required this.name,
    required this.comment,
    required this.profilePicture,
    required this.tiempoPublicado,
    required this.replies,
    required this.id,
    required this.placeId,
    this.isOwner = false,
  });

  static List<Comment> transformCanchaComments(body) {
    List<Comment> comments = [];

    for (Map comment in body) {
      Comment comentInfo = Comment(
        name: comment['nombre'],
        profilePicture: comment['photoURL'],
        comment: comment['comentario'],
        isOwner: comment['isOwner'],
        replies: Comment.transformCanchaComments(comment['replies']),
        tiempoPublicado: comment['tiempo_publicado'],
        id: comment['id'] ?? '',
        placeId: comment['place_id'],
      );

      comments.add(comentInfo);
    }

    return comments;
  }
}
