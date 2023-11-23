import 'package:meuapp/model/course_model.dart';
import 'package:meuapp/model/course_repository.dart';

class CourseController {
  CourseRepository repository = CourseRepository();

  Future<List<CourseEntity>> getCourseList() async {
    List<CourseEntity> coursesList = [];
    coursesList = await repository.getAll();
    return coursesList;
  }

  deleteCourse(String id) async {
    try {
      await repository.deleteCourse(id);
    } catch (e) {
      rethrow;
    }
  }

  postNewCourse(CourseEntity courseEntity) async {
    try {
      await repository.postNewCourse(courseEntity);
    } catch (e) {
      rethrow;
    }
  }
}
