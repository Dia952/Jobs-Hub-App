import 'package:flutter/material.dart';
import 'package:jobs_hub/Views/Profile/Experience/edit_experience.dart';
import 'package:jobs_hub/Views/Profile/edit_profile_screen.dart';
import 'package:jobs_hub/Views/Profile/Project/project_details_screen.dart';

import '../../Controllers/user_controller.dart';
import '../../Models/project_model.dart';
import '../../Models/user_model.dart';
import '../../Models/user_singleton.dart';
import 'Project/add_project_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  UserController userController = UserController();
  late TabController _tabController;
  late List<Project> projects;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User user = UserSingleton().user;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 200,
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Align(
                  alignment: AlignmentDirectional.topCenter,
                  child: Container(
                    height: 120.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      image: user.coverImage != null
                          ? DecorationImage(
                              image: FileImage(user.coverImage!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 62.0,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            child: CircleAvatar(
                              radius: 60.0,
                              backgroundImage: user.profileImage != null
                                  ? FileImage(user.profileImage!)
                                      as ImageProvider
                                  : const AssetImage(
                                      'assets/images/user_image.png'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 7),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 40,
                                ),
                                Text(
                                  '${user.firstName ?? ''} ${user.lastName ?? ''}',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                user.status != ''
                                    ? Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(4),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: Text(
                                            'Status : ${user.status ?? ''}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      )
                                    : const SizedBox(height: 15),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TabBar(
              controller: _tabController,
              indicatorColor: Theme.of(context).primaryColor,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.grey,
              labelStyle: const TextStyle(
                fontSize: 14,
              ),
              tabs: const [
                Tab(
                  text: 'Personal Info',
                ),
                Tab(
                  text: 'Experience',
                ),
                Tab(
                  text: 'Projects',
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 16.0),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            print(_tabController.index);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProfileScreen(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit_outlined),
                          label: const Text('Edit Profile'),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      _buildInfoRow('Name',
                          '${user.firstName ?? ''}  ${user.lastName ?? ''}'),
                      const SizedBox(height: 16.0),
                      _buildInfoRow('Username', user.username ?? ''),
                      const SizedBox(height: 16.0),
                      _buildInfoRow('Phone', user.phone ?? ''),
                      const SizedBox(height: 16.0),
                      _buildInfoRow('Email', user.email ?? ''),
                      const SizedBox(height: 16.0),
                      _buildInfoRow('City', user.city ?? ''),
                      const SizedBox(height: 16.0),
                      _buildInfoRow('Education', user.education ?? ''),
                      const SizedBox(height: 16.0),
                      _buildInfoRow('GPA', user.gpa ?? ''),
                      const SizedBox(height: 16.0),
                      _buildInfoRow(
                        'Bio',
                        user.bio ?? '',
                        maxLines: 5,
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16.0),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            print(_tabController.index);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditExperienceScreen(
                                  skills: user.skills ?? [],
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit_outlined),
                          label: const Text('Edit Experience'),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        'Experience',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Text(user.experience ?? ''),
                      const SizedBox(height: 16.0),
                      const Divider(),
                      const Text(
                        'Skills',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      _buildSkillsList(user.skills ?? []),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 16.0),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            print(_tabController.index);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddProjectScreen(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.add),
                          label: const Text('Add Project'),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      _buildDataTable(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsList(List<String> skills) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: skills.length,
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 5);
      },
      itemBuilder: (context, index) {
        return Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.fiber_manual_record_outlined,
                size: 10,
              ),
            ),
            Expanded(
              child: Text(
                skills[index],
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String text, {int maxLines = 1}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ),
        const SizedBox(
          width: 16.0,
        ),
        Expanded(
          flex: 7,
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16.0,
            ),
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildDataTable() {
    final columns = ['Project Title', 'Description'];
    projects = <Project>[
      Project(
          title: 'First Project',
          description:
              ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, ' *
                  20)),
      Project(title: 'Second Project', description: 'Description'),
      Project(title: 'Third Project', description: 'Description'),
      Project(title: '4th Project', description: 'Descriptionsssssss'),
      Project(
          title: 'Project with a very long name!',
          description:
              'This project is about something that is really long! and it is a test for this app'),
    ];
    return DataTable(
      dataRowHeight: 70,
      showCheckboxColumn: false,
      columns: getColumns(columns),
      rows: getRows(projects),
    );
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map(
        (String column) => DataColumn(
          label: Text(column),
        ),
      )
      .toList();

  List<DataRow> getRows(List<Project> projects) =>
      projects.map((Project project) {
        final cells = [project.title, project.description];
        return DataRow(
          onSelectChanged: (selected) {
            if (selected!) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProjectDetailsScreen(
                    projectTitle: project.title,
                    projectDescription: project.description,
                  ),
                ),
              );
            }
          },
          cells: getCells(cells),
        );
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) => cells
      .map(
        (data) => DataCell(
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 250,
              // minWidth: 10,
            ),
            child: Text(
              '$data',
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              maxLines: 3,
            ),
          ),
        ),
      )
      .toList();
}
