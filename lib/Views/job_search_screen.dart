import 'package:flutter/material.dart';

import '../Controllers/job_controller.dart';
import '../Models/job_model.dart';
import '../shared/components/components.dart';
import 'job_application_form_screen.dart';

class JobSearchScreen extends StatefulWidget {
  const JobSearchScreen({Key? key}) : super(key: key);

  @override
  State<JobSearchScreen> createState() => _JobSearchScreenState();
}

class _JobSearchScreenState extends State<JobSearchScreen> {
  JobController jobController = JobController();
  final searchController = TextEditingController();
  bool showPrefix = true;
  bool isSubmitted = false;

  @override
  void initState() {
    super.initState();
    jobController.fetchJobs();
    searchController.addListener(updatePrefixVisibility);
  }

  @override
  void dispose() {
    searchController.dispose();
    searchController.removeListener(updatePrefixVisibility);
    super.dispose();
  }

  void updatePrefixVisibility() {
    setState(() {
      showPrefix = searchController.text.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              onSubmitted: (String query) async {
                jobController.isLoadingNotifier.value = true;
                setState(() {
                  if (query.isEmpty && isSubmitted) {
                    isSubmitted = false;
                  } else {
                    isSubmitted = true;
                  }
                });
                await jobController.searchJobs(query);
                jobController.isLoadingNotifier.value = false;
              },
              decoration: InputDecoration(
                labelText: 'Search',
                border: const OutlineInputBorder(),
                prefixIcon:
                    showPrefix ? const Icon(Icons.search) : const SizedBox(),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Icon(Icons.search),
                        ),
                        onPressed: () async {
                          jobController.isLoadingNotifier.value = true;
                          setState(() {
                            if (searchController.text.isEmpty && isSubmitted) {
                              isSubmitted = false;
                            } else {
                              isSubmitted = true;
                            }
                          });
                          await jobController.searchJobs(searchController.text);

                          jobController.isLoadingNotifier.value = false;
                        },
                      )
                    : null,
              ),
            ),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: jobController.isLoadingNotifier,
            builder: (context, isLoading, child) {
              if (isSubmitted && isLoading) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(strokeWidth: 1.5),
                  ),
                );
              } else if (isSubmitted) {
                if (jobController.filteredJobs.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: jobController.filteredJobs.length,
                      itemBuilder: (BuildContext context, int index) {
                        final job = jobController.filteredJobs[index];
                        return jobCard(
                            job: job,
                            onApplyPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      JobApplicationFormScreen(), // Navigate to the ApplicationFormScreen
                                ),
                              );
                            },
                            onEmailPressed: () {
                              jobController.sendEmail(job.email, job.title);
                            });
                      },
                    ),
                  );
                } else {
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.sentiment_dissatisfied,
                          size: 100,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'No results found. Please try a different search term.',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }
              } else {
                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.search_outlined,
                        size: 100,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Search by Job Title, Requirements or Company Email',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
