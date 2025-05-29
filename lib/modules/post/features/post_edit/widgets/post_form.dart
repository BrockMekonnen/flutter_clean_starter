import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';

import '../../../../../_shared/widgets/show_loading_overlay.dart';
import '../../../../../_shared/widgets/show_toast_notification.dart';
import '../../post_listing/bloc/post_listing_bloc.dart';
import '../bloc/post_edit_bloc.dart';

class PostForm extends StatefulWidget {
  const PostForm({
    super.key,
    this.id,
    this.title,
    this.content,
    this.onSubmit,
  });

  final String? id;
  final String? title;
  final String? content;
  final void Function(String title, String content)? onSubmit;

  @override
  State<PostForm> createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  late GlobalKey<FormBuilderState> formKey;
  Map<String, dynamic> initialValue = {};

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormBuilderState>();
    initialValue = {
      "title": widget.title,
      "content": widget.content,
    };
  }

  void _handleSubmit() {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      var data = formKey.currentState!.value;
      String title = data['title'];
      String content = data['content'];
      BlocProvider.of<PostEditBloc>(context)
          .add(SavePostEvent(title: title, content: content, id: widget.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isEditing = widget.id != null;
    return BlocListener<PostEditBloc, PostEditState>(
      listener: (context, state) {
        String temp = isEditing ? "Update" : "Create";
        if (state is PostEditLoading) {
          LoadingOverlay.show();
        } else if (state is PostEditFailure) {
          LoadingOverlay.hide();
          CustomToast.showErrorNotification(
              title: "$temp Failed", description: state.message);
        } else if (state is PostEditSuccess) {
          LoadingOverlay.hide();
          CustomToast.showSuccessNotification(
              title: "$temp Successful",
              description: "Your post has been successfully ${temp}d");
          context
              .read<PostListingBloc>()
              .add(UpdatePostInListingEvent(state.post, isCreate: !isEditing));
          GoRouter.of(context).pop();
        }
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: FormBuilder(
              key: formKey,
              initialValue: initialValue,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),

                  /// Title field
                  FormBuilderTextField(
                    name: "title",
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  /// Content field
                  FormBuilderTextField(
                    name: "content",
                    maxLines: 8,
                    decoration: const InputDecoration(
                      labelText: 'Content',
                      hintText: "Write content details here",
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                    ),
                  ),
                  const SizedBox(height: 24),

                  /// Submit button
                  Align(
                    alignment: Alignment.centerRight,
                    child: FilledButton.icon(
                      onPressed: _handleSubmit,
                      style: FilledButton.styleFrom(minimumSize: Size(200, 50)),
                      icon: const Icon(Icons.save),
                      label: Text(isEditing ? 'Update' : 'Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
