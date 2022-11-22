
import 'package:srbg/entry/Album.dart';
import 'package:srbg/net/address.dart';
import 'package:srbg/net/result_data.dart';
import '../utils/Log.dart';
import 'http.dart';

Future<Album> fetchAlbum() async {

  final ResultData data = await HttpManager().get(Address.TEST_API,isLoading: true);
  if (data.isSuccess) {
    Log.v(data.data);
    return Album.fromJson(data.data);
  } else {
    throw Exception('Failed to load album');
  }
}
