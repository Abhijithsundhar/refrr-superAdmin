

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/common/alertbox.dart';
import '../../../core/common/image-Picker.dart';
import '../../../core/common/lodings.dart';
import '../../../core/common/snackbar.dart';
import '../../../core/globelvariable.dart';
import '../../../model/firm-model.dart';
import '../../../model/leads-model.dart';
import '../../../model/services-model.dart';
import '../../home/homepage.dart';
import '../Controllor/leads-controllor.dart';

class AddService extends ConsumerStatefulWidget {
  final AddFirmModel firm;
  final LeadsModel lead;
  const AddService({super.key, required this.firm, required this.lead});

  @override
  ConsumerState<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends ConsumerState<AddService> {
  PickedImage? pickedProfile;

  final _serviceNameController = TextEditingController();
  final _serviceRangeStartAmountController = TextEditingController();
  final _serviceRangeEndAmountController = TextEditingController();
  final _serviceCommissionController = TextEditingController();

  @override
  void dispose() {
    _serviceNameController.dispose();
    _serviceRangeStartAmountController.dispose();
    _serviceRangeEndAmountController.dispose();
    _serviceCommissionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(width * 0.05),
      child: Container(
        width: width * 0.5,
        height: height * 0.85,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(247, 247, 250, 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            _buildAppBar(width),
            Divider(height: 1, color: Colors.grey[300]),
            Expanded(
              child: Row(
                children: [
                  _buildImageSection(width, height),
                  _buildFormSection(width, height, context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(double width) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leadingWidth: 200,
      leading: Padding(
        padding: EdgeInsets.only(left: width * 0.01),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'ADD SERVICE',
            style: GoogleFonts.firaSansCondensed(
              fontSize: width * 0.01,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.close, color: Colors.black, size: width * 0.015),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  Widget _buildImageSection(double width, double height) {
    return Padding(
      padding: EdgeInsets.all(width * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add Image',
            style: GoogleFonts.firaSansCondensed(fontSize: width * 0.008),
          ),
          SizedBox(height: height * 0.005),
          InkWell(
            onTap: () async {
              final picked = await ImagePickerHelper.pickImage();
              if (picked != null) {
                setState(() => pickedProfile = picked);
              }
            },
            child: Container(
              width: width * 0.1,
              height: height * 0.15,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: pickedProfile != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.memory(pickedProfile!.bytes, fit: BoxFit.cover),
              )
                  : Image.asset('assets/images/addImage.png', fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormSection(double width, double height, BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: height * 0.01),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTextFieldRow('Name of Service :', _serviceNameController),
              SizedBox(height: height * 0.02),
              _buildPriceRangeRow(width),
              SizedBox(height: height * 0.02),
              _buildTextFieldRow('Commission (%) :', _serviceCommissionController),
              SizedBox(height: height * 0.04),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () => _handleSaveService(context),
                  child: Text('Save'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFieldRow(String label, TextEditingController controller) {
    return Row(
      children: [
        SizedBox(width: 150, child: Text(label)),
        Expanded(
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceRangeRow(double width) {
    return Row(
      children: [
        SizedBox(width: 150, child: Text('Range (AED) :')),
        Expanded(
          child: Row(
            children: [
              Expanded(child: TextFormField(
                controller: _serviceRangeStartAmountController,
                decoration: InputDecoration(labelText: 'From', border: OutlineInputBorder()),
              )),
              SizedBox(width: width * 0.01),
              Expanded(child: TextFormField(
                controller: _serviceRangeEndAmountController,
                decoration: InputDecoration(labelText: 'To', border: OutlineInputBorder()),
              )),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _handleSaveService(BuildContext context) async {
    final leadsNotifier = ref.read(leadsControllerProvider.notifier);

    // ✅ Always unfocus
    FocusManager.instance.primaryFocus?.unfocus();
    await Future.delayed(const Duration(milliseconds: 50));

    // ✅ Validate
    if (pickedProfile == null) {
      showCommonSnackbar(context, 'Please add image');
      return;
    }
    if (_serviceNameController.text.trim().isEmpty ||
        _serviceRangeStartAmountController.text.trim().isEmpty ||
        _serviceRangeEndAmountController.text.trim().isEmpty ||
        _serviceCommissionController.text.trim().isEmpty) {
      showCommonSnackbar(context, 'Please fill all fields');
      return;
    }

    final startPrice = int.tryParse(_serviceRangeStartAmountController.text.trim());
    final endPrice = int.tryParse(_serviceRangeEndAmountController.text.trim());
    final commission = int.tryParse(_serviceCommissionController.text.trim());

    if (startPrice == null || endPrice == null || commission == null || startPrice >= endPrice) {
      showCommonSnackbar(context, 'Invalid price range or commission');
      return;
    }

    final confirm = await showCustomAlertBoxss(context, 'Do you want to add this service?');
    if (confirm != true) return;

    showLoadings(context);

    try {
      final uploadedUrl = await ImagePickerHelper.uploadImageToFirebase(pickedProfile!);
      if (uploadedUrl == null) throw Exception('Image upload failed.');

      final newService = ServiceModel(
        image: uploadedUrl,
        name: _serviceNameController.text.trim(),
        startingPrice: startPrice,
        endingPrice: endPrice,
        commission: commission,
        leadsGiven: 0,
        createTime: DateTime.now(),
        delete: false,
      );

      final updatedServices = [...?widget.firm.services, newService];
      final updatedFirm = widget.firm.copyWith(services: updatedServices);

      final updatedFirms = widget.lead.firms.map((firm) {
        if (firm.name == widget.firm.name && firm.phoneNo == widget.firm.phoneNo) {
          return updatedFirm;
        }
        return firm;
      }).toList();

      final updatedLead = widget.lead.copyWith(firms: updatedFirms);

      await leadsNotifier.updateLeads(context: context, leadsModel: updatedLead);

      hideLoading(context);
      showCommonSnackbar(context, 'Service added successfully!');

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => Home(initialTabIndex: 2)));
    } catch (e) {
      hideLoading(context);
      showCommonSnackbar(context, 'Error: ${e.toString()}');
    }
  }
}
