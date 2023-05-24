import 'dart:math';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Models/job_model.dart';

class JobController {
  final List<Job> jobs = [];
  List<Job> filteredJobs = [];

  final int cardsPerPage = 5;

  int currentPage = 1;
  bool isLoading = false;

  final isLoadingNotifier = ValueNotifier<bool>(false);

  Future<void> fetchJobs() async {
    if (isLoading) return;

    isLoading = true;
    isLoadingNotifier.value = true;

    await Future.delayed(const Duration(milliseconds: 1000));

    // final fetchedJobs = [
    //   Job(
    //     title: 'Full Stack Eng.',
    //     description: 'We are looking for a great Full-Stack Dev.',
    //     requirements: '.NET, Angular',
    //     email: 'fs@dev.com',
    //     address: 'Job 1 address',
    //   ),
    //   Job(
    //     title: 'Mobile Developer',
    //     description: 'We are looking for an experienced Mobile Eng.',
    //     requirements: 'Flutter, Android, iOS',
    //     email: 'mb@hr.com',
    //     address: 'Job 2 address',
    //   ),
    //   Job(
    //     title: 'Backend Engineer',
    //     description: 'We are looking for a Python Geek!',
    //     requirements: 'Python, Django, NodeJS',
    //     email: 'geek@yolo.com',
    //     address: 'Job 3 address',
    //   ),
    // ];

    List<Job> fetchedJobs = List.generate(
      cardsPerPage,
      (index) {
        int jobNumber = (currentPage - 1) * cardsPerPage + index + 1;
        return Job(
            title: 'Job $jobNumber',
            description: 'Job $jobNumber description',
            requirements: 'Job $jobNumber requirements',
            email: 'job$jobNumber@example.com',
            address: 'Job $jobNumber address',
            deadline: '10-5-2023');
      },
    );

    jobs.addAll(fetchedJobs);
    currentPage++;
    isLoading = false;
    isLoadingNotifier.value = false;
  }

  Future<void> refreshJobs() async {
    jobs.clear();
    currentPage = 1;

    fetchJobs();
  }

  Future<void> searchJobs(String query) async {
    final trimmedQuery = query.trim();
    if (trimmedQuery.isEmpty) {
      filteredJobs = [];
      return;
    }

    if (query.isNotEmpty) {
      await fetchJobs();
    }

    // Remove consecutive spaces from the query
    final searchTerms = query.toLowerCase().split(' ');

    filteredJobs = jobs
        .where(
          (job) => searchTerms.every(
            (term) =>
                job.title.toLowerCase().contains(term) ||
                job.email.toLowerCase().contains(term) ||
                job.requirements.toLowerCase().contains(term),
          ),
        )
        .toList();
    // if (query.isNotEmpty) {
    //   await Future.delayed(const Duration(milliseconds: 1000));
    // }
  }

  void sendEmail(String email, String jobTitle) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': 'jobTitle',
        'body': 'I am applying for the position of $jobTitle.'
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch email app';
    }
  }
}
