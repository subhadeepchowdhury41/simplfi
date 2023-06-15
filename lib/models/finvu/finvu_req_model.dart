import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class FinVuReqHeader {
  String? rid;
  String? ts;
  final String channelId = 'finsense';

  FinVuReqHeader({this.ts, this.rid});

  Map<String, dynamic> getHeader() {
    rid = const Uuid().v4();
    ts = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").format(DateTime.now());
    return {'rid': rid, 'ts': ts, 'channelId': channelId};
  }
}
