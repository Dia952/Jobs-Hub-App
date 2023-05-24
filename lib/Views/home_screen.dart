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
    jobController.fetchJobs();
    scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      jobController.fetchJobs();
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
            if (!isLoading || jobController.jobs.isNotEmpty) {
              return CustomScrollView(
                controller: scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: CarouselSlider(
                      items: const [
                        Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://s3.us-east-2.amazonaws.com/medcerts.com-staging/blog/articles/7-fun-jobs-that-pay-well-without-a-degree/_800x418_crop_center-center_82_none/Different-Careers-Illustration-Smaller-01.png?mtime=1588720399'),
                        ),
                        Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://redlakejobs.ca/wp-content/uploads/2020/10/employment.jpg'),
                        ),
                        Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://www.urban.org/sites/default/files/2022-03/jobs-feature-header-1700x700_0.png'),
                        ),
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
                        if (jobController.jobs.isNotEmpty)
                          _buildJobList(jobController.jobs),
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
                      JobApplicationFormScreen(), // Navigate to the ApplicationFormScreen
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
