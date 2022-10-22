

// To parse this JSON data, do
//
//     final LatestModel = LatestModelFromJson(jsonString);

// ignore_for_file: non_constant_identifier_names

 

class LatestModel {

  
    int ?id;
    String? feature;
    String ?headline;
    String ?title;
     String? date;
    String ?image;
    String ?content;
    LatestModel({
        this.id,
        this.feature,
        this.headline,
        this.title,
        this.content,
        this.image,
        this.date,
    });


    factory LatestModel.fromJson(Map<String, dynamic> json) => LatestModel(
        id: json["id"],
        feature: json["feature"],
        title: json["title"],
        headline: json["headline"],
          content: json["content"],
        image: json["image"],
        date: json["date"],
    );

    Map<String, dynamic> toJson()  {
      final Map<String, dynamic> data = <String, dynamic>{};
data["id"]=id;
        data["title"]= title;
       data[ "headline"]=headline;
        data[ "feature"]=feature;
        data[  "date"]=date;
        data[ "image"]=image;
        data[ "content"]=content;
        return data;
    }
}
