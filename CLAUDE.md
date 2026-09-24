# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
flutter pub get                 # install dependencies
flutter run                     # run the app on the connected device
flutter analyze lib             # static analysis (flutter_lints)
flutter test                    # run all tests
flutter test test/widget_test.dart --plain-name 'smoke test'   # run a single test
flutter build apk               # release build
```

`test/widget_test.dart` is still the untouched Flutter counter template and fails against this app; there is no real test suite yet.

## Stack 

Flutter (Dart SDK `^3.12.2`), `flutter_bloc` + `equatable` for state, `dio` for HTTP, Firebase (`firebase_auth`, `cloud_firestore`, `google_sign_in`) for accounts and saved data, `shared_preferences` for local flags, `flutter_svg` for icons. Fonts: Inter (set globally as the app theme's `fontFamily`).

Movie data comes from the YTS API (`https://yts.gg/api/v2/`, no key required) through `DioApiClient.instance`, a lazily built singleton `Dio`. Paths live in `EndPoints`; `list_movies.json` is fetched as 4 pages of 50 in parallel and de-duplicated by id.

## Architecture

Four feature packages under `lib/`, each with the same clean-architecture layers, plus the UI in `lib/modules/`:

- `lib/auth/` — Firebase email/Google sign-in, profile updates, account deletion. Note the folder is literally named `data Source` (with a space), so imports of it are percent-encoded (`data%20Source`).
- `lib/movies/` — YTS list, search (`query_term`), movie details, and suggestions.
- `lib/watchlist/` — per-user saved movies in Firestore at `users/{uid}/watchlist/{movieId}`, exposed as a **stream** so the bookmark icon and the profile count stay in sync live.
- `lib/history/` — the last 20 movies whose details screen was opened, in Firestore at `users/{uid}/history/{movieId}`, also a **stream**. Writes dedupe by movie id and prune anything past 20.

Each package:

```
data/datasources/    raw API/Firebase calls, returns Models
data/models/         extend the Entity, add fromJson/toMap
data/repositories/   catch DioException/FirebaseException -> ServerException (Arabic messages)
domain/entities/     plain classes, no serialization
domain/repositories/ abstract contract
domain/usecases/     one class with a single call() method each
presentation/manager/  bloc + event + state + injection.dart
```

There is no DI container: each feature's `presentation/manager/injection.dart` has a `buildXBloc()` factory that news up data source → repository → use cases → bloc. Screens create blocs with these factories in a `BlocProvider`/`MultiBlocProvider`, so blocs are per-screen, not global.

`lib/modules/` holds screens grouped by flow (`splash`, `onBoarding`, `login`, `home`). `HomeView` is a `PageView` + `CustomBottomNavigationBar` over Home / Search / Browse / Profile. Named routes are registered in `AppRoutes.routes` with names in `AppRoutesName`; `MovieDetailsScreen` is pushed with `MaterialPageRoute` instead, since it takes a `movieId`.

Note the typos baked into paths — `wedgets/`, `wigets/`, `seacrh/serach.dart`, `buttom_model.dart` — match them when importing rather than "fixing" them piecemeal.

## Conventions

- **Reuse the project's own widgets in `lib/core/widgets/`** instead of raw Flutter ones: `CustomButton` (`buttom_model.dart`), `CustomTextFormField` (`textfromfield_model.dart`), `MovieCard`, `RatingBadge`, `LangSelector`. `CustomButton` defaults to a yellow background with black text, so pass `backgroundColor`/`textColor` when a screen needs otherwise.
- `MovieCard` renders a poster plus rating badge and navigates to `MovieDetailsScreen` unless given an `onTap`.
- Colors come from `AppColors` (`lib/core/app_colors/app_colors.dart`) — dark background `#121312`, dark grey `#282A28`, yellow `#FFBB3B`, red `#E82626`.
- Blocs are event-driven (`on<Event>`) and states are `Equatable`; states are separate subclasses (`XLoading`, `XLoaded`, `XError`), except `WatchlistState` and `HistoryState`, the stream-backed ones, which are single classes with `copyWith`.
- Designs are measured from a 430px-wide frame; translate sizes to ratios (for example the Similar grid uses `childAspectRatio: 189 / 279` with a 20px gap) rather than hardcoding pixel widths.
- Every screen must be responsive (the assignment grades it). `lib/core/responsive/responsive.dart` has `context.scaled(designSize)`, which scales a 430-frame size to the device's shortest side and stops growing at 500px, and `context.contentPadding(...)`, which keeps forms phone-width and centered on tablets and in landscape. Movie grids use `SliverGridDelegateWithMaxCrossAxisExtent` so they gain columns on wider screens, and screens that could outgrow a short or landscape screen scroll instead of using fixed heights.
- Firestore security rules must allow a signed-in user to read/write their own `users/{uid}` document **and** its `watchlist` and `history` subcollections.

## Git

Work happens on `task<N>` branches, one per task, each branched from the previous one (`task1` from `master`). The current one is `task4` (Search, Browse and Profile tabs); `task3` stops at the movie details screen and its suggestions, so don't add new work there. Commit messages are lowercase imperative summaries, e.g. "add movie details screen with BLoC state management and UI components".
