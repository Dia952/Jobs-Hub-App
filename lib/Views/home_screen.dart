import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../Controllers/job_controller.dart';
import '../Models/job_model.dart';
import '../shared/components/components.dart';
import 'job_application_form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final JobController jobController = JobController();

  final scrollController = ScrollController();
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    jobController.fetchHomeScreenJobs();
    scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      jobController.fetchNextJobs();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: refreshIndicatorKey,
        backgroundColor: Theme.of(context).primaryColor,
        color: Colors.white,
        strokeWidth: 1.5,
        onRefresh: () => jobController.refreshJobs(),
        child: ValueListenableBuilder<bool>(
          valueListenable: jobController.isLoadingNotifier,
          builder: (context, isLoading, _) {
            if (!isLoading || jobController.displayedJobs.isNotEmpty) {
              return CustomScrollView(
                controller: scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: CarouselSlider(
                      items: [
                        Image.asset('assets/images/1.png', fit: BoxFit.cover),
                        Image.asset('assets/images/2.png', fit: BoxFit.cover),
                        Image.asset('assets/images/3.png', fit: BoxFit.cover),
                      ],
                      options: CarouselOptions(
                        height: 180.0,
                        autoPlay: true,
                        viewportFraction: 1,
                        enableInfiniteScroll: true,
                        disableCenter: true,
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        const SizedBox(height: 10),
                        if (jobController.displayedJobs.isNotEmpty)
                          _buildJobList(jobController.displayedJobs),
                        if (jobController.isLoading)
                          Column(
                            children: const [
                              SizedBox(height: 10),
                              Center(
                                child:
                                    CircularProgressIndicator(strokeWidth: 1.5),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        if (jobController.displayedJobs.isEmpty &&
                            !jobController.isLoading)
                          const Center(
                            child: Text(
                              'An error occurred... Couldn\'t load jobs.',
                            ),
                          )
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(strokeWidth: 1.5),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildJobList(List<Job> jobs) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: jobs.length,
      itemBuilder: (BuildContext context, int index) {
        return jobCard(
            job: jobs[index],
            onApplyPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      JobApplicationFormScreen(jobId: jobs[index].id),
                ),
              );
            },
            onEmailPressed: () {
              jobController.sendEmail(jobs[index].email, jobs[index].title);
            });
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 8);
      },
    );
  }
}
