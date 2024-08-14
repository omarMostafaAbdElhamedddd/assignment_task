
// states for get grades
import 'grade_model.dart';

abstract class GetGradesStates{}
class Init  extends GetGradesStates{}
class Failure extends GetGradesStates{}
class Loading  extends GetGradesStates{}
class Success extends GetGradesStates{
  Success(this.grades);
  List<Grade> grades ;
}
