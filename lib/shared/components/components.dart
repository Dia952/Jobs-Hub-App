import 'package:flutter/material.dart';
import 'package:jobs_hub/shared/styles/colors.dart';
import 'package:intl/intl.dart';
import '../../Models/job_model.dart';

Widget defaultButton({
  double width = double.infinity,
  Color backgroundColor = primaryColor,
  bool isUpperCase = true,
  double radius = 10,
  required VoidCallback function,
  required String text,
  Color textColor = Colors.white,
}) =>
    Container(
      width: width,
      height: 40.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: MaterialButton(
        color: backgroundColor,
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType keyboardType,
  ValueChanged? onSubmit,
  ValueChanged? onChanged,
  FocusNode? focusNode,
  required String? Function(String?) validate,
  required String label,
  IconData? prefix,
  IconData? suffix,
  bool isPassword = false,
  VoidCallback? suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      validator: validate,
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      focusNode: focusNode,
      keyboardType: keyboardType,
      obscureText: isPassword,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor)),
        fillColor: Colors.white24,
        filled: true,
        labelText: label,
        labelStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 10.0,
        ),
        prefixIcon: Icon(
          prefix,
          size: 22,
        ),
        suffixIcon: IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffix,
            size: 22,
          ),
        ),
      ),
    );

Widget jobCard({
  required Job job,
  required VoidCallback onApplyPressed,
  required VoidCallback onEmailPressed,
}) =>
    Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    job.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Wrap(
                  spacing: 6.0,
                  runSpacing: 6.0,
                  children: [
                    const Icon(
                      Icons.access_time_filled,
                      color: Colors.grey,
                      size: 16,
                    ),
                    Text(
                      DateFormat('yyyy-MM-dd').format(job.deadline),
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              job.description,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            const Divider(),
            const Text(
              'Requirements',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              job.requirements,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            const Divider(),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                const Icon(
                  Icons.email,
                  color: Colors.grey,
                  size: 16,
                ),
                Text(
                  job.email,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 6.0,
              runSpacing: 6.0,
              children: [
                const Icon(
                  Icons.location_pin,
                  color: Colors.grey,
                  size: 16,
                ),
                Text(
                  job.address,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 6.0,
              runSpacing: 6.0,
              children: [
                const Icon(
                  Icons.access_time_filled,
                  color: Colors.grey,
                  size: 16,
                ),
                Text(
                  DateFormat('yyyy-MM-dd').format(job.deadline),
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 6.0,
              runSpacing: 6.0,
              children: [
                ElevatedButton.icon(
                  onPressed: onApplyPressed,
                  icon: const Icon(
                    Icons.check_circle,
                    size: 16, // Adjust the icon size as needed
                  ),
                  label: const Text(
                    'Apply',
                    style: TextStyle(
                      fontSize: 12,
                    ), // Adjust the text size as needed
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Company Profile button action
                  },
                  icon: const Icon(
                    Icons.business,
                    size: 16, // Adjust the icon size as needed
                  ),
                  label: const Text(
                    'Company Profile',
                    style: TextStyle(
                      fontSize: 12,
                    ), // Adjust the text size as needed
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: onEmailPressed,
                  icon: const Icon(
                    Icons.email,
                    size: 14, // Adjust the icon size as needed
                  ),
                  label: const Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 12,
                    ), // Adjust the text size as needed
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
