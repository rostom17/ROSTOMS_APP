abstract class BaseUsecase<ReturnType, Parameters> {
  Future<ReturnType> call(Parameters parameters);
}
