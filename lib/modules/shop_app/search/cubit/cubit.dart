import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mos/models/shop_app/search_model.dart';
import 'package:mos/modules/shop_app/search/cubit/states.dart';
import 'package:mos/shared/componantes/constance.dart';
import 'package:mos/shared/network/end_points.dart';
import 'package:mos/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void Search(String text)
  {
    emit(SearchLoadingState());
    DioHelper.postData(url: SEARCH,token: token,
        data: {
      'text':text
    }).then((value) {
      searchModel=SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SearchErrorState());
    });
  }


}