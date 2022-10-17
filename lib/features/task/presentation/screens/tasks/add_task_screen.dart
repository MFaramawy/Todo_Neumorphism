import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/media_query_values.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:todo_app/features/task/presentation/cubit/task_cubit.dart';
import 'package:todo_app/features/task/presentation/widgets/form_field.dart';
import 'package:todo_app/features/task/presentation/widgets/dropdown_field.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = TasksCubit.get(context);
    return BlocConsumer<TasksCubit, TasksState>(
      listener: (context, state) {
        if (state is CreateTaskSuccessState) {
          Navigator.pop(context);
          cubit.clearController();
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: NeumorphicBackground(
            child: Form(
              key: cubit.formKey,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(height: context.height / 20),
                  SizedBox(
                    width: context.width,
                    height: context.height / 12,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final size =
                            constraints.maxWidth + constraints.maxHeight;
                        return Row(
                          children: [
                            SizedBox(width: size / 50),
                            NeumorphicButton(
                              minDistance: -5,
                              style: const NeumorphicStyle(
                                depth: 3,
                                intensity: 5,
                                boxShape: NeumorphicBoxShape.circle(),
                              ),
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                size: size / 20,
                                color: AppColors.primary,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                            SizedBox(width: size / 5),
                            NeumorphicText(
                              'New Task',
                              style:
                                  const NeumorphicStyle(depth: 2, intensity: 5),
                              textStyle:
                                  NeumorphicTextStyle(fontSize: size / 16),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: context.height / 80),
                  CustomTextField(
                    hintText: 'Title',
                    controller: cubit.titleController,
                    prefixIcon: Icons.title_rounded,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Field is require';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    hintText: 'Note',
                    controller: cubit.noteController,
                    prefixIcon: Icons.edit_note,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Field is require';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    readOnly: true,
                    hintText: 'Date',
                    controller: cubit.dateController,
                    prefixIcon: Icons.date_range_rounded,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Field is require';
                      }
                      return null;
                    },
                    onTap: () => cubit.customShowDatePicker(context),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          readOnly: true,
                          hintText: 'Start Time',
                          controller: cubit.startTimeController,
                          prefixIcon: Icons.watch_later_outlined,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field is require';
                            }
                            return null;
                          },
                          onTap: () async {
                            await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            ).then((value) {
                              value != null
                                  ? cubit.startTimeController.text =
                                      value.format(context)
                                  : null;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: context.width / 20),
                      Expanded(
                        child: CustomTextField(
                          readOnly: true,
                          hintText: 'End Time',
                          controller: cubit.endTimeController,
                          prefixIcon: Icons.watch_later_outlined,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field is require';
                            }
                            return null;
                          },
                          onTap: () async {
                            await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            ).then((value) {
                              value != null
                                  ? cubit.endTimeController.text =
                                      value.format(context)
                                  : null;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  CustomDropDownFromField(
                    items: cubit.reminder,
                    hintText: 'Reminder',
                    value: cubit.reminderValue,
                    prefixIcon: Icons.notifications_active_outlined,
                    onChanged: (value) => cubit.reminderValue = value,
                    validator: (value) {
                      if (value == null) {
                        return 'Field is require';
                      }
                      return null;
                    },
                  ),
                  CustomDropDownFromField(
                    items: cubit.repeat,
                    hintText: 'Repeat',
                    value: cubit.repeatValue,
                    onChanged: (value) => cubit.repeatValue = value,
                    prefixIcon: Icons.repeat_rounded,
                    validator: (value) {
                      if (value == null) {
                        return 'Field is require';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: context.height / 40),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children:
                        List<Widget>.generate(cubit.colors.length, (index) {
                      return InkWell(
                        onTap: () => cubit.changeColor(index),
                        child: BlocBuilder<TasksCubit, TasksState>(
                          builder: (context, state) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: CircleAvatar(
                                radius: context.height / 65,
                                backgroundColor: cubit.colors[index],
                                child: cubit.selectedColor == index
                                    ? const Icon(Icons.done,
                                        color: Colors.white)
                                    : null,
                              ),
                            );
                          },
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: context.height / 15),
                  Visibility(
                    visible: state is! CreateTaskLoadingState,
                    replacement: const CupertinoActivityIndicator(),
                    child: NeumorphicButton(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.symmetric(horizontal: 130),
                      style: NeumorphicStyle(
                        depth: 4,
                        intensity: 4,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(20)),
                      ),
                      minDistance: -4,
                      child: Text(
                        'Create Task',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      onPressed: () async {
                        if (cubit.formKey.currentState!.validate()) {
                          cubit.createTask();
                          await cubit.getAllTasks();
                        }
                      },
                    ),
                  ),
                  SizedBox(height: context.height / 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
