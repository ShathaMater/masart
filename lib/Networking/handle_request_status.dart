import 'package:masarat/Networking/status_request.dart';

import 'api_request.dart';

void handleRequestStatus(
  RResponse response, {
  required Function() onSucsses,
}) {
  if (response.statusRequest == StatusRequest.success) {
    onSucsses();
  } else if (response.statusRequest == StatusRequest.serverFailure) {
    String msg = (response.response?.data is String)
        ? response.response?.data != ''
            ? response.response!.data
            : response.response?.statusMessage
        : 'Server Error';
    // ShowToast.show(msg: msg, isSuccess: false);
    if (msg == 'Unauthorized') {
      //
    }
  } else {
    // ShowToast.show(msg: 'No internet connectivity', isSuccess: false);
  }
}
//////////////////////////////////////////////////////////////