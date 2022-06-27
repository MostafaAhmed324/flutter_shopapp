
class HomeModel
{
  late bool status;
  late HomeDataModel data;
  HomeModel.fromJson(Map<String,dynamic> json)
  {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel
{
  List banners=[];
  List products=[];

  HomeDataModel.fromJson(Map<String,dynamic> json)
  {
    json['banners'].forEach((element)
    {
      banners.add(element);
    });

    json['products'].forEach((element)
    {
      products.add(element);
    });
  }

}

class BannersModel
{
  late int id;
  late String image;
  BannersModel.fromJson(Map<String,dynamic> json)
  {
    id = json['id'];
    image = json['image'];
  }
}

class ProductsModel
{
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late String image;
  late String name;
  late int discount;
  late bool inFavorite;
  late bool inCart;

  ProductsModel.fromJson(Map<String,dynamic> json)
  {
    id = json['id'];
    image = json['image'];
    price = json['price'];
    oldPrice = json['old_price'];
    name = json['name'];
    discount = json['discount'];
    inFavorite = json['in_favorites'];
    inCart = json['in_cart'];

  }
}