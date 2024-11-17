import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

typedef TappableState = ({bool hovered});

class Tappable extends StatefulWidget {
  final String? semanticLabel;
  final bool selected;
  final bool excludeSemantics;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final ValueWidgetBuilder<TappableState> builder;
  final Widget? child;

  factory Tappable.animated({
    String? semanticLabel,
    bool selected,
    bool excludeSemantics,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    ValueWidgetBuilder<TappableState>? builder,
    Widget? child,
    Key? key,
  }) = _AnimatedTappable;

  Tappable({
    this.semanticLabel,
    this.selected = false,
    this.excludeSemantics = false,
    this.onTap,
    this.onLongPress,
    ValueWidgetBuilder<TappableState>? builder,
    this.child,
    super.key,
  })  : assert(builder != null || child != null,
            'Either builder or child must be provided.'),
        builder = builder ?? ((_, __, child) => child!);

  bool get enabled => onTap != null || onLongPress != null;

  @override
  State<Tappable> createState() => _TappableState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(FlagProperty('enabled',
          value: enabled, ifTrue: 'enabled', level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('semanticLabel', semanticLabel,
          level: DiagnosticLevel.debug))
      ..add(FlagProperty('selected',
          value: selected, ifTrue: 'selected', level: DiagnosticLevel.debug))
      ..add(
        FlagProperty(
          'excludeSemantics',
          value: excludeSemantics,
          ifTrue: 'excludeSemantics',
          level: DiagnosticLevel.debug,
        ),
      )
      ..add(DiagnosticsProperty('onTap', onTap, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('onLongPress', onLongPress,
          level: DiagnosticLevel.debug))
      ..add(
          DiagnosticsProperty('builder', builder, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('child', child, level: DiagnosticLevel.debug));
  }
}

class _TappableState extends State<Tappable>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final tappable = Semantics(
      enabled: widget.enabled,
      label: widget.semanticLabel,
      container: true,
      button: true,
      selected: widget.selected,
      excludeSemantics: widget.excludeSemantics,
      child: MouseRegion(
        cursor: widget.enabled ? SystemMouseCursors.click : MouseCursor.defer,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: _child,
      ),
    );

    if (widget.onTap == null) {
      return tappable;
    }

    return Shortcuts(
      shortcuts: const {
        SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
      },
      child: Actions(
        actions: {
          ActivateIntent:
              CallbackAction<ActivateIntent>(onInvoke: (_) => widget.onTap!()),
        },
        child: tappable,
      ),
    );
  }

  Widget get _child => GestureDetector(
        onTap: widget.onTap,
        onLongPress: widget.onLongPress,
        child: widget.builder(context, (hovered: _hovered), widget.child),
      );
}

class _AnimatedTappable extends Tappable {
  _AnimatedTappable({
    super.semanticLabel,
    super.selected = false,
    super.excludeSemantics = false,
    super.onTap,
    super.onLongPress,
    super.builder,
    super.child,
    super.key,
  });

  @override
  State<Tappable> createState() => _AnimatedTappableState();
}

class _AnimatedTappableState extends _TappableState {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 70));
    _animation = Tween(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeInOutQuint,
      ),
    );
    // ..addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     _controller.reverse();
    //   }
    // });
  }

  Future<void> _waitForAnimationCompletion() {
    final completer = Completer<void>();
    void listener(AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _controller.removeStatusListener(listener);
        completer.complete();
      }
    }

    _controller.addStatusListener(listener);
    return completer.future;
  }

  @override
  Widget get _child => ScaleTransition(
        scale: _animation,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.onTap == null
              ? null
              : () {
                  widget.onTap!();
                },
          onTapDown: widget.onTap == null
              ? null
              : (details) {
                  _controller.forward();
                },
          onTapUp: widget.onTap == null
              ? null
              : (details) async {
                  if (_controller.isCompleted) {
                    _controller.reverse();
                  } else {
                    await _waitForAnimationCompletion();
                    _controller.reverse();
                  }
                },
          onTapCancel: widget.onTap == null
              ? null
              : () async {
                  if (_controller.isCompleted) {
                    _controller.reverse();
                  } else {
                    await _waitForAnimationCompletion();
                    _controller.reverse();
                  }
                },
          onLongPress: widget.onLongPress,
          child: widget.builder(context, (hovered: _hovered), widget.child),
        ),
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
