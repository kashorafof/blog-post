import 'package:blog_poster/Util/view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  final T Function(BuildContext) vmBuilder;
  final Widget Function(BuildContext, T) builder;

  const BaseView({
    required this.vmBuilder,
    required this.builder,
    super.key,
  }) : super();

  @override
  _BaseViewState createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: widget.vmBuilder(context),
      child: Consumer<T>(
        builder: _buildScreenContent,
      ),
    );
  }

  Widget _buildScreenContent(
          BuildContext context, T viewModel, Widget? child) =>
      /*!viewModel.isInitialized
          ? Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ): */ // ! may need to return this but currently remove to remove the loading affect when changing page
          
           Stack(
              children: [
                widget.builder(context, viewModel),
                Visibility(
                  visible: viewModel.isLoading,
                  child: Center(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                )
              ],
            );
}
