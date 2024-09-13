import 'package:ecomm_mobile/utility/app_color.dart';
import 'package:ecomm_mobile/utility/extensions.dart';
import 'package:ecomm_mobile/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MyAddressScreen extends StatelessWidget {
  const MyAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.profileProvider.retrieveSavedAddress();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Address',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColor.darkOrange,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: context.profileProvider.addressFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    surfaceTintColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(
                            validator: (value) => value!.isEmpty
                                ? 'Please enter a phone number'
                                : null,
                            labelText: 'Phone',
                            controller:
                                context.profileProvider.streetController,
                            onSave: (value) {},
                            inputType: TextInputType.number,
                          ),
                          CustomTextField(
                            controller:
                                context.profileProvider.streetController,
                            labelText: 'Street',
                            onSave: (value) {},
                            validator: (value) =>
                                value!.isEmpty ? 'Please enter a street' : null,
                          ),
                          CustomTextField(
                            controller: context.profileProvider.cityController,
                            onSave: (value) {},
                            labelText: 'City',
                            validator: (value) =>
                                value!.isEmpty ? 'Please enter a state' : null,
                          ),
                          CustomTextField(
                            controller: context.profileProvider.stateController,
                            labelText: 'State',
                            onSave: (value) {},
                            validator: (value) =>
                                value!.isEmpty ? 'Please enter a state' : null,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  labelText: 'Postal Code',
                                  onSave: (value) {},
                                  inputType: TextInputType.number,
                                  controller:
                                      context.profileProvider.postalCodeController,
                                  validator: (value) => value!.isEmpty
                                      ? 'Please enter a code'
                                      : null,
                                ),
                              ),
                              const Gap(10),
                              Expanded(
                                child: CustomTextField(
                                  labelText: 'Country',
                                  controller:
                                      context.profileProvider.countryController,
                                  onSave: (value) {},
                                  validator: (value) => value!.isEmpty
                                      ? 'Please enter a country'
                                      : null,
                                ),
                              )
                            ],
                          ),
                          const Gap(20),
                          Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.darkOrange,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: () {
                                if (context.profileProvider.addressFormKey
                                    .currentState!.validate()) {
                                  context.profileProvider.storeAddress();
                                }
                              },
                              child: const Text(
                                'Update Address',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
