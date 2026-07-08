import 'package:flutter/material.dart';

/// Widget de shimmer (esqueleto carregando) reutilizável.
/// Exibe barras animadas com gradiente que simulam o carregamento de conteúdo.
class ShimmerLoading extends StatefulWidget {
  final int itemCount;
  final ShimmerType type;

  const ShimmerLoading({super.key, this.itemCount = 5, this.type = ShimmerType.list});

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final shimmerBase = cs.surfaceContainerHighest;
    final shimmerHighlight = cs.surfaceContainerLow;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final gradient = LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [shimmerBase, shimmerHighlight, shimmerBase],
          stops: const [0.4, 0.5, 0.6],
        );

        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          itemCount: widget.itemCount,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(color: Colors.black.withAlpha(4), borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.all(16),
              child: _buildShimmerItem(gradient),
            );
          },
        );
      },
    );
  }

  Widget _buildShimmerItem(LinearGradient gradient) {
    switch (widget.type) {
      case ShimmerType.list:
        return Row(
          children: [
            _shimmerBox(gradient, width: 48, height: 48, borderRadius: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _shimmerBox(gradient, width: double.infinity, height: 14),
                  const SizedBox(height: 8),
                  _shimmerBox(gradient, width: 120, height: 12),
                ],
              ),
            ),
            _shimmerBox(gradient, width: 32, height: 32, borderRadius: 16),
          ],
        );
      case ShimmerType.card:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _shimmerBox(gradient, width: 40, height: 40, borderRadius: 8),
            const SizedBox(height: 12),
            _shimmerBox(gradient, width: double.infinity, height: 22),
            const SizedBox(height: 8),
            _shimmerBox(gradient, width: 80, height: 14),
          ],
        );
      case ShimmerType.stats:
        return Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  _shimmerBox(gradient, width: 32, height: 32, borderRadius: 16),
                  const SizedBox(height: 8),
                  _shimmerBox(gradient, width: 60, height: 16),
                  const SizedBox(height: 4),
                  _shimmerBox(gradient, width: 40, height: 12),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  _shimmerBox(gradient, width: 32, height: 32, borderRadius: 16),
                  const SizedBox(height: 8),
                  _shimmerBox(gradient, width: 50, height: 16),
                  const SizedBox(height: 4),
                  _shimmerBox(gradient, width: 60, height: 12),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  _shimmerBox(gradient, width: 32, height: 32, borderRadius: 16),
                  const SizedBox(height: 8),
                  _shimmerBox(gradient, width: 60, height: 16),
                  const SizedBox(height: 4),
                  _shimmerBox(gradient, width: 55, height: 12),
                ],
              ),
            ),
          ],
        );
    }
  }

  Widget _shimmerBox(LinearGradient gradient, {double? width, required double height, double borderRadius = 6}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(gradient: gradient, borderRadius: BorderRadius.circular(borderRadius)),
    );
  }
}

enum ShimmerType { list, card, stats }
