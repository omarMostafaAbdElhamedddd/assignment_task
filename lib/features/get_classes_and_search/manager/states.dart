abstract class GetClassesStates{}
class Init  extends GetClassesStates{}
class FailureClass extends GetClassesStates{}
class LoadingClass  extends GetClassesStates{}
class SuccessClass extends GetClassesStates{
  SuccessClass(this.classes);
  List<dynamic> classes ;
}
