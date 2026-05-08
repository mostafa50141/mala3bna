import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

class ImageUploadSection extends StatefulWidget {
  const ImageUploadSection({super.key});

  @override
  State<ImageUploadSection> createState() => _ImageUploadSectionState();
}

class _ImageUploadSectionState extends State<ImageUploadSection> {
  final ImagePicker _picker = ImagePicker();
  late final MultiImagePickerController _imageController;

  @override
  void initState() {
    super.initState();
    _imageController = MultiImagePickerController(
      maxImages: 10,
      images: [],
      picker: (int pickCount, Object? params) async {
        final pickedFiles = await _picker.pickMultiImage();
        return pickedFiles
            .take(pickCount)
            .map((xFile) => convertXFileToImageFile(xFile))
            .toList();
      },
    );
  }

  /*void _submit() {
    final images = _imageController.images;
    if (images.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please add at least one image")),
      );
      return;
    }

    for (final image in images) {
      if (image.hasPath) print("Image path: ${image.path}");
    }
    Navigator.pop(context);
  }*/

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.colorBtnAndCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.primaryColor.withOpacity(0.25),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: MultiImagePickerView(
          controller: _imageController,
          padding: const EdgeInsets.all(4),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          builder: (context, imageFile) {
            return Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ImageFileView(
                      imageFile: imageFile,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: GestureDetector(
                    onTap: () => _imageController.removeImage(imageFile),
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: Colors.redAccent,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          initialWidget: GestureDetector(
            onTap: _imageController.pickImages,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.12),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primaryColor.withOpacity(0.4),
                      ),
                    ),
                    child: Icon(
                      Icons.cloud_upload_outlined,
                      size: 32,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Tap to upload images',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'PNG, JPG up to 5MB',
                    style: TextStyle(color: Colors.white38, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          addMoreButton: IconButton(
            icon: Icon(
              Icons.add_circle_outline,
              size: 30,
              color: AppColors.primaryColor,
            ),
            onPressed: _imageController.pickImages,
          ),
        ),
      ),
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:mala3bna/core/utils/style.dart';

class ImageUploadSection extends StatelessWidget {
  const ImageUploadSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.greenAccent),
            color: const Color(0xFF0E2A21),
          ),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 30),
                const Icon(
                  Icons.cloud_upload,
                  color: Colors.greenAccent,
                  size: 20,
                ),
                const SizedBox(height: 8),
                Text('Tap to upload images', style: Style.textStyle16Bold),
                const SizedBox(height: 4),
                Text(
                  "PNG, JPG up to 5MB",
                  style: Style.textStyle14.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        /// Preview images
        SizedBox(
          height: 80,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) => ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(width: 100, color: Colors.grey.shade700),
            ),
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemCount: 2,
          ),
        ),
      ],
    );
  }
}
*/
