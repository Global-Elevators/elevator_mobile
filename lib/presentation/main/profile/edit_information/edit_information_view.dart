import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/app/dependency_injection.dart';
import 'package:elevator/app/network_aware_widget.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:elevator/presentation/main/home/widgets/custom_app_bar.dart';
import 'package:elevator/presentation/main/profile/edit_information/edit_information_viewmodel.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:elevator/presentation/widgets/build_date_of_birth_section_widget.dart';
import 'package:elevator/presentation/widgets/build_name_section.dart';
import 'package:elevator/presentation/widgets/button_widget.dart';
import 'package:elevator/presentation/widgets/email_field.dart';
import 'package:elevator/presentation/widgets/items_drop_down.dart';
import 'package:elevator/presentation/widgets/label_field.dart';
import 'package:elevator/presentation/widgets/phone_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class EditInformationView extends StatefulWidget {
  static const String routeName = '/edit-information';

  const EditInformationView({super.key});

  @override
  State<EditInformationView> createState() => _EditInformationViewState();
}

class _EditInformationViewState extends State<EditInformationView> {
  // ---------------- CONTROLLERS ----------------
  final _firstName = TextEditingController();
  final _fatherName = TextEditingController();
  final _grandFather = TextEditingController();
  final _day = TextEditingController();
  final _month = TextEditingController();
  final _year = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();

  // ---------------- ADDRESS ----------------
  final _addresses = ['Cairo', 'Alexandria', 'Mansoura'];
  String? _selectedAddress;

  // ---------------- VIEWMODEL ----------------
  final _viewmodel = instance<EditInformationViewModel>();

  // ---------------- DATE ----------------
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _viewmodel.start();

    // Fill UI when ContentState is produced
    _viewmodel.outputStateStream.listen(
      (state) => (state is ContentState) ? _fillUI() : null,
    );
  }

  void _fillUI() {
    final user = _viewmodel.userDataModel?.user;
    if (user == null) return;

    _firstName.text = user.name;
    _fatherName.text = user.profile?.sirName ?? '';
    _grandFather.text = user.profile?.lastName ?? '';
    _email.text = user.email ?? '';
    _phone.text = user.phone;

    // Date
    final bd = DateTime.tryParse(user.birthdate);
    if (bd != null) {
      _selectedDate = bd;
      _day.text = bd.day.toString();
      _month.text = bd.month.toString();
      _year.text = bd.year.toString();
    }

    final backendAddress = user.address.trim();
    _selectedAddress = _addresses.firstWhere(
      (a) => a.toLowerCase() == backendAddress.toLowerCase(),
      orElse: () => '',
    );
    if (_selectedAddress!.isEmpty) _selectedAddress = null;

    setState(() {});
  }

  @override
  void dispose() {
    _firstName.dispose();
    _fatherName.dispose();
    _grandFather.dispose();
    _day.dispose();
    _month.dispose();
    _year.dispose();
    _phone.dispose();
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NetworkAwareWidget(
      onlineChild: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: Strings.editInformation.tr(),
          showBackButton: true,
          popOrGo: true,
        ),
        body: StreamBuilder<FlowState>(
          stream: _viewmodel.outputStateStream,
          initialData: LoadingState(
            stateRendererType: StateRendererType.fullScreenLoadingState,
          ),
          builder: (context, snapshot) {
            return snapshot.data?.getStateWidget(
                  context,
                  _buildContent(),
                  () {},
                ) ??
                _buildContent();
          },
        ),
      ),
    );
  }

  // ---------------- UI CONTENT ----------------
  Widget _buildContent() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // _buildPendingReviewSection(),
            // Gap(AppSize.s20.h),

            // Name Section
            BuildNameSection(
              firstNameController: _firstName,
              fatherNameController: _fatherName,
              grandFatherNameController: _grandFather,
            ),

            // Date of Birth
            BuildDateOfBirthSectionWidget(
              dayController: _day,
              monthController: _month,
              yearController: _year,
              onDateSelected: (date) {
                _selectedDate = date;
                _day.text = date.day.toString();
                _month.text = date.month.toString();
                _year.text = date.year.toString();
              },
            ),

            // Phone
            LabelField(Strings.phoneNumberTitle.tr()),
            Gap(AppSize.s8.h),
            PhoneField(controller: _phone),
            Gap(AppSize.s20.h),


            // Email
            EmailField(emailController: _email),

            // Address
            LabelField(Strings.addressLabel.tr()),
            Gap(AppSize.s8.h),
            ItemsDropDown(
              items: _addresses,
              hintText: "Select your address",
              selectedItem: _selectedAddress,
              onChanged: (v) => setState(() => _selectedAddress = v),
            ),

            Gap(AppSize.s20.h),

            // Apply Button
            ButtonWidget(
              radius: AppSize.s14.r,
              text: Strings.apply.tr(),
              onTap: () {
                _viewmodel.updateUserData(
                  _firstName.text,
                  _email.text,
                  _phone.text,
                  _selectedDate.toString(),
                  _selectedAddress ?? "",
                  _fatherName.text,
                  _grandFather.text,
                );
              },
            ),
            Gap(AppSize.s16.h),
          ],
        ),
      ),
    );
  }
}
