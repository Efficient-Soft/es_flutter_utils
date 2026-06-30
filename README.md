# es_flutter_utils

`es_flutter_utils` is a small Flutter utility package with helpers for state handling, formatting, colors, phone actions, widget metadata, and general-purpose extensions.

## What is inside

### Public entrypoint

Import the package through:

```dart
import 'package:es_flutter_utils/es_flutter_utils.dart';
```

That export surface includes:

- `src/utils.dart`
- `src/extensions/generic_exts.dart`
- `src/models/mystate.dart`
- `src/models/widget_metadata.dart`

### Utility modules

| File | Purpose |
| --- | --- |
| `lib/src/utils/common_utils.dart` | Exception wrapping, list chunking, deep-ish map/list merging, and colored logging |
| `lib/src/utils/math_utils.dart` | Angle conversion, random 6-digit generation, and range mapping |
| `lib/src/utils/format_utils.dart` | Number, currency, duration, and distance formatting |
| `lib/src/utils/color_utils.dart` | Named color lookup and random color generation |
| `lib/src/utils/phone_utils.dart` | Myanmar phone validation and dial intent launch |
| `lib/src/utils/widget_utils.dart` | Post-frame callbacks, widget position metadata, and a test sliver list |
| `lib/src/utils/constants.dart` | Shared constants, currently a long lorem ipsum string |

### Extensions

`lib/src/extensions/generic_exts.dart` adds lightweight Kotlin-style helpers:

- `also`
- `apply`
- `modify`
- `tryCast`
- `ifNotNull`
- `let`

### Models

`lib/src/models/mystate.dart`

Provides a sealed `MyState<T>` abstraction with four states:

- `InitialState<T>`
- `LoadingState<T>`
- `SuccessState<T>`
- `ErrorState<T>`

It also includes convenience helpers:

- `isInitial`, `isLoading`, `isSuccess`, `isError`
- `hasData`, `requireData`, `error`
- `when(...)`
- `mapData(...)`
- `map(...)`
- `animateWidget(...)`

`lib/src/models/widget_metadata.dart`

Stores widget layout metadata:

- `position`
- `size`
- `constraints`

## Dependencies

This package currently uses:

- `flutter`
- `intl`
- `url_launcher`
- `colorize`

## Usage examples

### State handling

```dart
final state = MyState<String>.loading();

final label = state.map(
  initial: () => 'Idle',
  onLoading: (_) => 'Loading',
  onSuccess: (value) => 'Success: $value',
  onError: (error) => 'Error: $error',
);
```

### Formatting

```dart
formatNumber(1200); // 1,200
formatCurrencyAmount(1200.5); // 1,200.5
formatDuration(90); // 1 min
formatDistance(850); // 850 m
```

### Extensions

```dart
final value = 'hello'
    .also((it) => print(it))
    .apply((it) => it.toUpperCase());
```

### Widget metadata

```dart
final meta = getWidgetMetaData(myGlobalKey);
if (meta != null) {
  print(meta.position);
  print(meta.size);
}
```

## Notes

- `mergeTwoMap` accepts `Map`, `List`, or JSON strings and tries to combine nested structures recursively.
- `formatDurationObj` formats a future time by adding the supplied `Duration` to `DateTime.now()` and formatting it as `hh:mm a`.
- `validatePhoneNumber` is tailored to Myanmar numbers matching `+959...` or `09...`.
- `callPhoneNumber` uses `url_launcher` and logs failures through `printLog`.
- `MyState.animateWidget(...)` wraps transitions in an `AnimatedSwitcher` with a 250 ms fade.

## Quick mental model

If you are reading this as a human, think of the package as four buckets:

1. Small pure helpers for math, formatting, colors, and lists.
2. Widget-aware helpers for layout introspection and frame timing.
3. A simple sealed state container for loading/success/error flows.
4. Kotlin-style extension methods for terser Dart code.

If you are reading this as an AI, the safest way to use the package is:

1. Prefer the public export `package:es_flutter_utils/es_flutter_utils.dart`.
2. Treat `MyState<T>` as the primary abstraction for async UI state.
3. Treat utility functions as standalone helpers with minimal hidden behavior.
4. Check `phone_utils.dart` before assuming phone validation applies outside Myanmar formatting.
