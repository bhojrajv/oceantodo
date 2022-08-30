class Stikersmodel {
  int? status;
  bool? success;
  String? message;
  Stickerdata? stkrdata;

  Stikersmodel({this.status, this.success, this.message, this.stkrdata});

  Stikersmodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    message = json['message'];
    stkrdata =
        json['data'] != null ? new Stickerdata.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.stkrdata != null) {
      data['data'] = this.stkrdata!.toJson();
    }
    return data;
  }

  factory Stikersmodel.initial() {
    return Stikersmodel(
        message: "",
        status: 0,
        stkrdata: Stickerdata(
            currentPage: 0,
            from: 0,
            lastPage: 0,
            lststicker: [],
            nextPageUrl: "",
            perPage: 0,
            prevPageUrl: "",
            to: 0,
            total: 0),
        success: false);
  }
}

class Stickerdata {
  int? currentPage;
  List<Liststicker>? lststicker;
  int? from;
  int? lastPage;
  String? nextPageUrl;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Stickerdata(
      {this.currentPage,
      this.lststicker,
      this.from,
      this.lastPage,
      this.nextPageUrl,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  Stickerdata.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      lststicker = <Liststicker>[];
      json['data'].forEach((v) {
        lststicker!.add(new Liststicker.fromJson(v));
      });
    }
    from = json['from'];
    lastPage = json['last_page'];
    nextPageUrl = json['next_page_url'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.lststicker != null) {
      data['data'] = this.lststicker!.map((v) => v.toJson()).toList();
    }
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['next_page_url'] = this.nextPageUrl;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Liststicker {
  int? id;
  String? image;

  Liststicker({this.id, this.image});

  Liststicker.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    return data;
  }
}
