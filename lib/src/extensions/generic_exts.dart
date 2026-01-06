extension TExts<T> on T {
  T also(Function(T) fun) {
    fun(this);
    return this;
  }

  k apply<k>(k Function(T) fun) {
    return fun(this);
  }

  k modify<k>(k Function(T) fun) {
    return fun(this);
  }

  K? tryCast<K>() {
    return this is K ? this as K : null;
  }

  void ifNotNull(void Function(T) cb) {
    if (this != null) {
      cb(this);
    }
  }
}
