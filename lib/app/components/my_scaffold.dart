import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyScaffold extends GetResponsiveView {
  MyScaffold({
    super.key,
    required this.child,
    required this.title,
    this.floatingActionButton,
    this.actions = const [],
  }) : super(alwaysUseBuilder: false, settings: ResponsiveScreenSettings());

  @override
  Widget phone() => _buildContent(Get.context!, isMobile: true);

  @override
  Widget tablet() => _buildContent(Get.context!, isTablet: true);

  @override
  Widget desktop() => _buildContent(Get.context!, isTablet: true);

  final Widget child;
  final String title;
  final Widget? floatingActionButton;

  final List<Widget> actions;
  Widget _buildContent(
    BuildContext context, {
    bool isMobile = false,
    bool isTablet = false,
  }) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: const Color(0xFFF7F8FA),
        title: Text(
          title,
          style: TextStyle(
            fontSize: isTablet ? 32 : 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: actions,
      ),

      body: SafeArea(
        child: Padding(padding: const EdgeInsets.all(16), child: child),
      ),
      floatingActionButtonLocation:
          MediaQuery.of(context).orientation == Orientation.landscape
          ? FloatingActionButtonLocation.endContained
          : FloatingActionButtonLocation.centerFloat,
      floatingActionButton: floatingActionButton,
    );
  }
}
