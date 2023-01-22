import 'package:flutter/cupertino.dart';

import 'news_item_data.dart';

Widget newsItem(NewsItemData data) {
  return Container(
    child: Text(data.title),
  );
}
