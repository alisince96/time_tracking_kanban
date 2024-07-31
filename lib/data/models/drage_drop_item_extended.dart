import 'package:drag_and_drop_lists/drag_and_drop_item.dart';
import 'package:time_tracking_app/data/models/task_response.dart';

class DrageDropItemExtended extends DragAndDropItem {
  TaskResponse? task;
  DrageDropItemExtended({required super.child, this.task});
}
