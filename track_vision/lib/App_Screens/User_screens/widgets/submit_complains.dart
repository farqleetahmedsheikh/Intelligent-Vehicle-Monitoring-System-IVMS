import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: implementation_imports
import 'package:flutter_riverpod/src/core.dart';
import 'package:track_vision/Auth/user/user_fileupload.dart';
import 'package:track_vision/utils/constant_colors.dart';

class UserComplainsSubmit extends ConsumerStatefulWidget {
  const UserComplainsSubmit({super.key});

  @override
  ConsumerState<UserComplainsSubmit> createState() =>
      _UserComplaintsSubmitState();
}

class _UserComplaintsSubmitState extends ConsumerState<UserComplainsSubmit> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ownerEmail = TextEditingController();
  final TextEditingController _ownerCnic = TextEditingController();
  final TextEditingController _carMake = TextEditingController();
  final TextEditingController _carVariant = TextEditingController();
  final TextEditingController _carModel = TextEditingController();
  final TextEditingController _carPlateNumber = TextEditingController();
  final TextEditingController _carChassisNumber = TextEditingController();
  final TextEditingController _carColor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Image picker State
    final state = ref.watch(fileUploadProvider);
    final notifier = ref.read(fileUploadProvider.notifier);

    final fileName = state.file?.name ?? 'No file Chosen';

    return Scaffold(
      backgroundColor: ConstantColors.textLightMode.withOpacity(0.85),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Title
              const Text(
                "Submit a Complaint",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: ConstantColors.textDarkMode,
                ),
              ),
              //
              const SizedBox(height: 20),
              // Form fields for submit complaints
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Owner Details title
                    const Text(
                      "Owner Details",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: ConstantColors.textDarkMode,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Owner Email
                    const Text(
                      "Owner Email",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: ConstantColors.textDarkMode,
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white70,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      controller: _ownerEmail,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        final emailRegex = RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        );
                        if (!emailRegex.hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    // Owner CNIC
                    const Text(
                      "Owner CNIC",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: ConstantColors.textDarkMode,
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white70,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      controller: _ownerCnic,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your CNIC number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),

                    // Vehicle Details title
                    const Text(
                      "Vehicle Details",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: ConstantColors.textDarkMode,
                      ),
                    ),
                    const SizedBox(height: 20),

                    //
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Car Make Textfield
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Car Make",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: ConstantColors.textDarkMode,
                                ),
                              ),
                              const SizedBox(height: 6),
                              TextFormField(
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white70,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                ),
                                controller: _carMake,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Car Make';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 5),
                        //Car Model Textfield
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Car Model",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: ConstantColors.textDarkMode,
                                ),
                              ),
                              const SizedBox(height: 6),
                              TextFormField(
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white70,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                ),
                                controller: _carModel,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your car model';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    // Car Variant Textfield
                    const Text(
                      "Car Variant",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: ConstantColors.textDarkMode,
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white70,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      controller: _carVariant,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your car variant';
                        }
                        return null;
                      },
                    ),
                    //
                    const SizedBox(height: 20.0),
                    // Car Color Dropdown
                    const Text(
                      "Select Car Color",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: ConstantColors.textDarkMode,
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _carColor,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white70,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                    //
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Car Make Textfield
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Car Plate Number",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: ConstantColors.textDarkMode,
                                ),
                              ),
                              const SizedBox(height: 6),
                              TextFormField(
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white70,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                ),
                                controller: _carPlateNumber,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your car plate number';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 5),
                        //Car Model Textfield
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Car Chassis Number",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: ConstantColors.textDarkMode,
                                ),
                              ),
                              const SizedBox(height: 6),
                              TextFormField(
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white70,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                ),
                                controller: _carChassisNumber,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your car chassis number';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20.0),

                    // Upload Car Picture
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Upload Vehicle Image',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: ConstantColors.textDarkMode,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            border: Border.all(
                              color: ConstantColors.textDarkMode,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              ElevatedButton(
                                onPressed: state.isLoading
                                    ? null
                                    : notifier.pickImage,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ConstantColors
                                      .backgroundLight
                                      .withOpacity(0.6),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  side: BorderSide(
                                    color: ConstantColors.textDarkMode
                                        .withOpacity(0.6),
                                  ),
                                ),
                                child: Text(
                                  state.isLoading
                                      ? 'Loading...'
                                      : 'Choose file',
                                  style: TextStyle(
                                    color: ConstantColors.textDarkMode,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  fileName,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ),
                              if (state.file != null)
                                IconButton(
                                  tooltip: 'Clear',
                                  icon: const Icon(Icons.close, size: 18),
                                  onPressed: notifier.clear,
                                ),
                            ],
                          ),
                        ),
                        if (state.error != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            state.error!,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
