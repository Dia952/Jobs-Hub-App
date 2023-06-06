import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Models/job_model.dart';
import '../Models/user_model.dart';
import '../Models/user_singleton.dart';
import '../Services/job_service.dart';

class JobController {
  final JobService _jobService = JobService();
  final User user = UserSingleton().user;

  List<Job> allJobs = [];
  List<Job> fetchedJobs = [];
  List<Job> displayedJobs = [];
  List<Job> filteredJobs = [];

  final int cardsPerPage = 5;

  int currentPage = 1;
  bool isLoading = false;

  final isLoadingNotifier = ValueNotifier<bool>(false);

  Future<void> fetchAllJobs() async {
    if (isLoading) return;

    isLoading = true;
    isLoadingNotifier.value = true;
    allJobs = await _jobService.getJobs();
    isLoading = false;
    isLoadingNotifier.value = false;
  }

  Future<void> fetchHomeScreenJobs() async {
    await fetchAllJobs();

    await fetchNextJobs();
  }

  Future<void> fetchNextJobs() async {
    if (isLoading) return;

    isLoading = true;
    isLoadingNotifier.value = true;

    await Future.delayed(const Duration(milliseconds: 1000));

    int startIndex = (currentPage - 1) * cardsPerPage;
    int endIndex = startIndex + cardsPerPage;

    if (startIndex >= allJobs.length) {
      // No more jobs to fetch
      isLoading = false;
      isLoadingNotifier.value = false;
      return;
    }

    // Adjust endIndex to avoid exceeding the list length
    if (endIndex > allJobs.length) {
      endIndex = allJobs.length;
    }

    int categoryComparator(Job a, Job b) {
      // Compare the similarity of job categories to the user's interest
      int similarityA =
          a.category?.toLowerCase() == user.interest?.toLowerCase() ? 1 : 0;
      int similarityB =
          b.category?.toLowerCase() == user.interest?.toLowerCase() ? 1 : 0;

      // Sort in descending order of similarity
      return similarityB.compareTo(similarityA);
    }

    fetchedJobs = allJobs.reversed.toList().sublist(startIndex, endIndex);
    fetchedJobs.sort(categoryComparator);

    displayedJobs.addAll(fetchedJobs);
    currentPage++;
    isLoading = false;
    isLoadingNotifier.value = false;
  }

  Future<void> refreshJobs() async {
    displayedJobs.clear();
    currentPage = 1;

    fetchHomeScreenJobs();
  }

  Future<void> searchJobs(String query) async {
    final trimmedQuery = query.trim();
    if (trimmedQuery.isEmpty) {
      filteredJobs = [];
      return;
    }

    await fetchAllJobs();
    isLoading = true;
    isLoadingNotifier.value = true;
    await Future.delayed(const Duration(milliseconds: 1000));

    // Remove consecutive spaces from the query
    final searchTerms = query.toLowerCase().split(' ');

    filteredJobs = allJobs
        .where(
          (job) => searchTerms.every(
            (term) =>
                job.title.toLowerCase().contains(term) ||
                job.email.toLowerCase().contains(term) ||
                job.requirements.toLowerCase().contains(term),
          ),
        )
        .toList()
        .reversed
        .toList();

    isLoading = false;
    isLoadingNotifier.value = false;
  }

  void sendEmail(String email, String jobTitle) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': jobTitle,
        'body': "I am applying for the position of $jobTitle."
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch email app';
    }
  }

  Future<int> jobApply(
    String fullName,
    String email,
    String city,
    String phone,
    String gpa,
    int jobId,
    String cvFileName,
    // cvFileBytes,
  ) async {
    try {
      int res = await _jobService.jobApply(
        fullName,
        email,
        city,
        phone,
        gpa,
        jobId,
        cvFileName,
        // cvFileBytes,
      );
      return res;
    } catch (error) {
      debugPrint('Job Apply Error: $error');
      return 0;
    }
  }
}
