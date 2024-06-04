import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:second_app/models/user.dart';
import 'package:second_app/service/service_info.dart';
import 'package:second_app/utils/common_loader.dart';
import 'package:second_app/utils/screen_utils.dart';

class HomePageView extends StatefulWidget {
  final User user;
  final String? accessToken;
  final VoidCallback? refreshUserList;

  const HomePageView({
    Key? key,
    required this.user,
    required this.accessToken,
    this.refreshUserList,
  }) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final GlobalKey<State> key = GlobalKey<State>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildUserDetail(Icons.person, 'Name',
                  widget.user.data!.user!.name.toString()),
              _buildUserDetail(Icons.phone, 'Phone Number',
                  widget.user.data!.user!.phoneNumber.toString()),
              _buildUserDetail(Icons.male, 'Gender',
                  widget.user.data!.user!.gender.toString()),
              _buildUserDetail(Icons.place, 'Place of Birth',
                  widget.user.data!.user!.placeOfBirth.toString()),
              _buildUserDetail(Icons.calendar_today, 'Date of Birth',
                  widget.user.data!.user!.dateOfBirth.toString()),
              _buildUserDetail(Icons.access_time, 'Time of Birth',
                  widget.user.data!.user!.timeOfBirth.toString()),
              _buildUserDetail(Icons.info, 'Status',
                  widget.user.data!.user!.status.toString()),
              _buildUserDetail(Icons.calendar_today, 'Created At',
                  widget.user.data!.user!.createdAt.toString()),
              _buildUserDetail(Icons.calendar_today, 'Updated At',
                  widget.user.data!.user!.updatedAt.toString()),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () async {
                  LoaderDialog.showLoadingDialog(context, key);

                  final response =
                      await ServiceInfo.deleteUser(widget.accessToken!);
                  if (response.success == true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(response.message.toString()),
                      ),
                    );

                    Navigator.of(context).pop();
                    widget.refreshUserList?.call();
                  } else {
                    Navigator.of(context).pop();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('Failed to delete user: ${response.message}'),
                      ),
                    );
                  }
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                label: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.red.shade200),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  _showUpdateDialog(context);
                },
                icon: const Icon(
                  Icons.update,
                  color: Colors.white,
                ),
                label: const Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all(Colors.blue.shade200),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUserDetail(IconData icon, String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                '$title: $value',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showUpdateDialog(BuildContext context) async {
    String? name = widget.user?.data?.user?.name.toString();
    String? gender = widget.user?.data?.user?.gender.toString();
    String? placeOfBirth = widget.user?.data?.user?.placeOfBirth.toString();
    String? status = widget.user?.data?.user?.status.toString();
    DateTime? dateOfBirth = widget.user?.data?.user?.dateOfBirth;

    TimeOfDay? timeOfBirth = TimeOfDay.fromDateTime(
        widget.user?.data?.user?.timeOfBirth ?? DateTime.now());

    Future<void> _selectDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: dateOfBirth ?? DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      );
      if (pickedDate != null && pickedDate != dateOfBirth) {
        setState(() {
          dateOfBirth = pickedDate;
        });
      }
    }

    Future<void> _selectTime(BuildContext context) async {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: timeOfBirth ?? TimeOfDay.now(),
      );
      if (pickedTime != null && pickedTime != timeOfBirth) {
        setState(() {
          timeOfBirth = pickedTime;
        });
      }
    }

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Update User'),
              content: Container(
                height: ScreenUtil.getScreenSize(context).height* 0.6,
                width: ScreenUtil.getScreenSize(context).width*0.9,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        initialValue: name,
                        onChanged: (value) {
                          setState(() {
                            name = value;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            borderSide: BorderSide(width: 1.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        initialValue: placeOfBirth,
                        onChanged: (value) {
                          setState(() {
                            placeOfBirth = value;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'Place of Birth',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            borderSide: BorderSide(width: 1.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text('Gender:'),
                          Radio<String>(
                            value: 'male',
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value!;
                              });
                            },
                          ),
                          const Text('Male',style: TextStyle(fontSize: 10),),
                          Radio<String>(
                            value: 'female',
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value!;
                              });
                            },
                          ),
                          const Text('Female',style: TextStyle(fontSize: 10),),
                        ],
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Date of Birth'),
                        subtitle: Text(DateFormat('yyyy-MM-dd')
                            .format(dateOfBirth ?? DateTime.now())),
                        onTap: () async {
                          await _selectDate(context);
                          setState(() {});
                        },
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Time of Birth'),
                        subtitle: Text(
                          '${timeOfBirth?.hour}:${timeOfBirth?.minute}',
                        ),
                        onTap: () async {
                          await _selectTime(context);
                          setState(() {});
                        },
                      ),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Status'),
                        value: status == 'active',
                        onChanged: (value) {
                          setState(() {
                            status = value ? 'active' : 'inactive';
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(Colors.red.shade200),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(Colors.blue.shade200),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          LoaderDialog.showLoadingDialog(context, key);

                          final update = await ServiceInfo.updateUserData(
                            widget.accessToken ?? '',
                            name!,
                            gender!,
                            placeOfBirth!,
                            status!,
                            dateOfBirth ?? DateTime.now(),
                            timeOfBirth!,
                          );

                          if (update.success == true) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('User data updated successfully'),
                              ),
                            );
                            widget.refreshUserList?.call();

                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Failed to update user data: ${update.message}'),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}
