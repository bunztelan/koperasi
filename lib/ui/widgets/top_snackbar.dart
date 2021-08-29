import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

const String ERROR_BAR_ROUTE = "/errorBarRoute";
typedef void SnackBarStatusCallback(SnackBarStatus status);

// ignore: must_be_immutable
class TopSnackBar<T> extends StatefulWidget {
  final SnackBarStatusCallback onStatusChanged;
  final Duration duration;
  final String message;
  final Color backgroundColor;

  SnackRoute<T> _errorRoute;

  TopSnackBar(
      {this.message,
      this.duration = const Duration(seconds: 2),
      this.onStatusChanged,
      this.backgroundColor = Colors.transparent});

  Future<T> show(BuildContext context) async {
    _errorRoute = showTopSnackBar(
      context: context,
      snackBar: this,
    );

    return await Navigator.of(context, rootNavigator: false).push(_errorRoute);
  }

  Future<T> dismiss([T result]) async {
    // If route was never initialized, do nothing
    if (_errorRoute == null) {
      return null;
    }

    if (_errorRoute.isCurrent) {
      _errorRoute.navigator.pop(result);
      return _errorRoute.completed;
    } else if (_errorRoute.isActive) {
      // removeRoute is called every time you dismiss a Flushbar that is not the top route.
      // It will not animate back and listeners will not detect FlushbarStatus.IS_HIDING or FlushbarStatus.DISMISSED
      // To avoid this, always make sure that Flushbar is the top route when it is being dismissed
      _errorRoute.navigator.removeRoute(_errorRoute);
    }

    return null;
  }

  @override
  _TopSnackBarState createState() =>
      _TopSnackBarState(onCloseButtonClicked: () => dismiss());
}

class _TopSnackBarState extends State<TopSnackBar> {
  final Function() onCloseButtonClicked;

  _TopSnackBarState({@required this.onCloseButtonClicked});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Container(
          height: 55,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
          ),
          child: Row(
            children: [
              SizedBox(width: 24),
              Text(
                widget.message,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: Colors.white,
                      fontSize: 13,
                    ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsetsDirectional.only(end: 10),
                  alignment: AlignmentDirectional.centerEnd,
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: onCloseButtonClicked,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum SnackBarStatus { SHOWING, DISMISSED, IS_APPEARING, IS_HIDING }

class SnackRoute<T> extends OverlayRoute<T> {
  final TopSnackBar snackBar;
  final Builder _builder;
  final Completer<T> _transitionCompleter = Completer<T>();

  SnackBarStatusCallback _onStatusChanged;
  bool _wasDismissedBySwipe = false;
  Timer _timer;
  T _result;
  SnackBarStatus currentStatus;

  SnackRoute({
    @required this.snackBar,
    RouteSettings settings,
  })  : _builder = Builder(builder: (BuildContext innerContext) => snackBar),
        super(settings: settings) {
    _onStatusChanged = snackBar.onStatusChanged ?? (status) {};
  }

  Future<T> get completed => _transitionCompleter.future;
  bool get opaque => false;

  @override
  Iterable<OverlayEntry> createOverlayEntries() {
    final List<OverlayEntry> overlays = [];

    overlays.add(
      OverlayEntry(
          builder: (BuildContext context) {
            final Widget annotatedChild = Semantics(
              child: AlignTransition(
                alignment: _animation,
                child: _getDismissibleFlushbar(_builder),
              ),
              focused: false,
              container: true,
              explicitChildNodes: true,
            );
            return annotatedChild;
          },
          maintainState: false,
          opaque: opaque),
    );

    return overlays;
  }

  /// This string is a workaround until Dismissible supports a returning item
  String dismissibleKeyGen = "";

  Widget _getDismissibleFlushbar(Widget child) {
    return Dismissible(
      direction: DismissDirection.up,
      resizeDuration: null,
      confirmDismiss: (_) {
        if (currentStatus == SnackBarStatus.IS_APPEARING ||
            currentStatus == SnackBarStatus.IS_HIDING) {
          return Future.value(false);
        }
        return Future.value(true);
      },
      key: Key(dismissibleKeyGen),
      onDismissed: (_) {
        dismissibleKeyGen += "1";
        _cancelTimer();
        _wasDismissedBySwipe = true;

        if (isCurrent) {
          navigator.pop();
        } else {
          navigator.removeRoute(this);
        }
      },
      child: _builder,
    );
  }

  @override
  bool get finishedWhenPopped =>
      _controller.status == AnimationStatus.dismissed;

  /// The animation that drives the route's transition and the previous route's
  /// forward transition.
  Animation<Alignment> get animation => _animation;
  Animation<Alignment> _animation;

  /// The animation controller that the route uses to drive the transitions.
  ///
  /// The animation itself is exposed by the [animation] property.
  @protected
  AnimationController get controller => _controller;
  AnimationController _controller;

  /// Called to create the animation that exposes the current progress of
  /// the transition controlled by the animation controller created by
  /// [createAnimationController()].
  Animation<Alignment> createAnimation() {
    assert(!_transitionCompleter.isCompleted,
        'Cannot reuse a $runtimeType after disposing it.');
    assert(_controller != null);
    return AlignmentTween(
            begin: Alignment(-1.0, -2.0), end: Alignment(-1.0, -1.0))
        .animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCirc,
        reverseCurve: Curves.easeOutCirc,
      ),
    );
  }

  //copy of `routes.dart`
  void _handleStatusChanged(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.completed:
        currentStatus = SnackBarStatus.SHOWING;
        _onStatusChanged(currentStatus);
        if (overlayEntries.isNotEmpty) overlayEntries.first.opaque = opaque;

        break;
      case AnimationStatus.forward:
        currentStatus = SnackBarStatus.IS_APPEARING;
        _onStatusChanged(currentStatus);
        break;
      case AnimationStatus.reverse:
        currentStatus = SnackBarStatus.IS_HIDING;
        _onStatusChanged(currentStatus);
        if (overlayEntries.isNotEmpty) overlayEntries.first.opaque = false;
        break;
      case AnimationStatus.dismissed:
        assert(!overlayEntries.first.opaque);
        // We might still be the current route if a subclass is controlling the
        // the transition and hits the dismissed status. For example, the iOS
        // back gesture drives this animation to the dismissed status before
        // popping the navigator.
        currentStatus = SnackBarStatus.DISMISSED;
        _onStatusChanged(currentStatus);

        // if (!isCurrent) {
        //   navigator.finalizeRoute(this);
        //   assert(overlayEntries.isEmpty);
        // }
        break;
    }
    changedInternalState();
  }

  @override
  void install() {
    assert(!_transitionCompleter.isCompleted,
        'Cannot install a $runtimeType after disposing it.');
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      debugLabel: debugLabel,
      vsync: navigator,
    );
    assert(_controller != null,
        '$runtimeType.createAnimationController() returned null.');
    _animation = createAnimation();
    assert(_animation != null, '$runtimeType.createAnimation() returned null.');
    super.install();
  }

  @override
  TickerFuture didPush() {
    assert(_controller != null,
        '$runtimeType.didPush called before calling install() or after calling dispose().');
    assert(!_transitionCompleter.isCompleted,
        'Cannot reuse a $runtimeType after disposing it.');
    _animation.addStatusListener(_handleStatusChanged);
    _configureTimer();
    super.didPush();
    return _controller.forward();
  }

  @override
  void didReplace(Route<dynamic> oldRoute) {
    assert(_controller != null,
        '$runtimeType.didReplace called before calling install() or after calling dispose().');
    assert(!_transitionCompleter.isCompleted,
        'Cannot reuse a $runtimeType after disposing it.');
    if (oldRoute is SnackRoute) _controller.value = oldRoute._controller.value;
    _animation.addStatusListener(_handleStatusChanged);
    super.didReplace(oldRoute);
  }

  @override
  bool didPop(T result) {
    assert(_controller != null,
        '$runtimeType.didPop called before calling install() or after calling dispose().');
    assert(!_transitionCompleter.isCompleted,
        'Cannot reuse a $runtimeType after disposing it.');

    _result = result;
    _cancelTimer();

    if (_wasDismissedBySwipe) {
      Timer(Duration(milliseconds: 200), () {
        _controller.reset();
      });

      _wasDismissedBySwipe = false;
    } else {
      _controller.reverse();
    }

    return super.didPop(result);
  }

  void _configureTimer() {
    if (snackBar.duration != null) {
      if (_timer != null && _timer.isActive) {
        _timer.cancel();
      }
      _timer = Timer(snackBar.duration, () {
        if (isCurrent) {
          navigator.pop();
        } else if (isActive) {
          navigator.removeRoute(this);
        }
      });
    } else {
      if (_timer != null) {
        _timer.cancel();
      }
    }
  }

  void _cancelTimer() {
    if (_timer != null && _timer.isActive) {
      _timer.cancel();
    }
  }

  @override
  void dispose() {
    assert(!_transitionCompleter.isCompleted,
        'Cannot dispose a $runtimeType twice.');
    _controller?.dispose();
    _transitionCompleter.complete(_result);
    super.dispose();
  }

  /// A short description of this route useful for debugging.
  String get debugLabel => '$runtimeType';

  @override
  String toString() => '$runtimeType(animation: $_controller)';
}

SnackRoute showTopSnackBar<T>(
    {@required BuildContext context, @required TopSnackBar snackBar}) {
  return SnackRoute<T>(
    snackBar: snackBar,
    settings: RouteSettings(name: ERROR_BAR_ROUTE),
  );
}
