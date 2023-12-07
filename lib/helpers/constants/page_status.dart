abstract class IPageStatus {}

class InitialPageStatue extends IPageStatus {}

class LoadingPageStatus extends IPageStatus {}

class SuccessPageStatus<Data> extends IPageStatus {
  final Data data;
  SuccessPageStatus(this.data);
}

class ErrorPageStatus extends IPageStatus {
  final String message;

  ErrorPageStatus(this.message);
}
