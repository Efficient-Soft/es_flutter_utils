import 'package:flutter/widgets.dart';

sealed class MyState<T> {
  MyState();

  factory MyState.initial() => InitialState();
  factory MyState.loading({T? data}) => LoadingState(data: data);
  factory MyState.error(Object? error, {T? data}) =>
      ErrorState(error, data: data);
  factory MyState.success(T data) => SuccessState(data);

  bool get isInitial => this is InitialState;
  bool get isSuccess => this is SuccessState;
  bool get isError => this is ErrorState;
  bool get hasError => this is ErrorState;
  bool get isLoading => this is LoadingState;
  bool get hasData => data != null;

  T? get data {
    if (this is SuccessState) {
      return (this as SuccessState).data;
    } else if (this is LoadingState) {
      return (this as LoadingState).data;
    } else if (this is ErrorState) {
      return (this as ErrorState).data;
    }
    return null;
  }

  T get requireData {
    assert(
      data != null,
      'data is null and it should not be when force call via requireData',
    );
    return data!;
  }

  Object? get error => (this is ErrorState) ? (this as ErrorState).error : null;
  void when({
    void Function()? onLoading,
    void Function(T)? onSuccess,
    void Function(Object? error)? onError,
  }) {
    if (this is LoadingState) {
      onLoading?.call();
    } else if (this is SuccessState) {
      onSuccess?.call(data as T);
    } else if (this is ErrorState) {
      onError?.call(error);
    }
  }

  MyState<K> mapData<K>(K Function(T) map) {
    if (this is LoadingState) {
      return LoadingState<K>();
    } else if (this is SuccessState) {
      return SuccessState<K>(map(data as T));
    } else if (this is ErrorState) {
      return ErrorState<K>(error);
    } else {
      return InitialState<K>();
    }
  }

  K map<K>({
    required K Function(T?) onLoading,
    required K Function(T) onSuccess,
    required K Function(Object? error) onError,
    required K Function() initial,
  }) {
    if (this is LoadingState) {
      return onLoading(data);
    } else if (this is SuccessState) {
      return onSuccess(data as T);
    } else if (this is ErrorState) {
      return onError(error);
    } else {
      return initial();
    }
  }

  Widget animateWidget({
    required Widget Function(T?) onLoading,
    required Widget Function(T) onSuccess,
    required Widget Function(Object? error) onError,
    Widget Function()? initial,
  }) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation, // Smooth fade effect
          child: child,
        );
      },
      child: switch (this) {
        LoadingState l => KeyedSubtree(
          key: const ValueKey('loading'),
          child: onLoading(l.data),
        ),
        ErrorState e => KeyedSubtree(
          key: const ValueKey('error'),
          child: onError(e.error),
        ),
        SuccessState s => KeyedSubtree(
          key: const ValueKey('success'),
          child: onSuccess(s.data),
        ),
        InitialState _ => KeyedSubtree(
          key: const ValueKey('initial'),
          child: initial?.call() ?? const SizedBox.shrink(),
        ),
      },
    );
  }

  @override
  String toString() {
    return 'MyState is : $runtimeType';
  }
}

final class InitialState<T> extends MyState<T> {
  InitialState();
}

final class SuccessState<T> extends MyState<T> {
  @override
  final T data;
  SuccessState(this.data);
}

final class ErrorState<T> extends MyState<T> {
  @override
  final Object? error;
  @override
  final T? data;
  ErrorState(this.error, {this.data});
}

final class LoadingState<T> extends MyState<T> {
  @override
  final T? data;
  LoadingState({this.data});
}
