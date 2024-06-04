import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:someonetoview/constants.dart';
import 'package:someonetoview/main_app_bar.dart';
import 'package:someonetoview/models/available_times.dart';
import 'package:someonetoview/models/furniture_listing.dart';
import 'package:someonetoview/models/location.dart';
import 'package:someonetoview/models/property_listing.dart';
import 'package:someonetoview/models/vehicle_listing.dart';
import 'package:someonetoview/pages/post_listing/time_slot_section_widget.dart';
import 'package:someonetoview/providers/furniture_provider.dart';
import 'package:someonetoview/providers/property_provider.dart';
import 'package:someonetoview/providers/vehicles_provider.dart';
import 'package:uuid/uuid.dart';

class PostListingPage extends ConsumerStatefulWidget {
  const PostListingPage({super.key});

  @override
  ConsumerState createState() => _PostListingPageState();
}

class _PostListingPageState extends ConsumerState<PostListingPage> {
  final _propertyFormKey = GlobalKey<FormState>();
  final _vehicleFormKey = GlobalKey<FormState>();
  final _furnitureFormKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final mileageController = TextEditingController();
  final conditionController = TextEditingController();
  final bedroomController = TextEditingController();
  final bathroomController = TextEditingController();
  final priceController = TextEditingController();
  final streetAddressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final zipCodeController = TextEditingController();
  final descriptionController = TextEditingController();

  String selectedPropertyType = '';
  List<String> propertyImages = [];
  List<String> vehicleImages = [];
  List<String> furnitureImages = [];

  final availableTimes = AvailableTimes(
    sunday: 'none',
    monday: 'none',
    tuesday: 'none',
    wednesday: 'none',
    thursday: 'none',
    friday: 'none',
    saturday: 'none',
  );

  Map<String, bool> dayValues = {
    'Sunday': false,
    'Monday': false,
    'Tuesday': false,
    'Wednesday': false,
    'Thursday': false,
    'Friday': false,
    'Saturday': false,
  };

  void _updateDay(String day) {
    switch (day) {
      case 'Sunday':
        availableTimes.sunday = 'none';
        break;
      case 'Monday':
        availableTimes.monday = 'none';
        break;
      case 'Tuesday':
        availableTimes.tuesday = 'none';
        break;
      case 'Wednesday':
        availableTimes.wednesday = 'none';
        break;
      case 'Thursday':
        availableTimes.thursday = 'none';
        break;
      case 'Friday':
        availableTimes.friday = 'none';
        break;
      case 'Saturday':
        availableTimes.saturday = 'none';
        break;
    }
  }

  void _updateTimeSlot(String day, String start, String end) {
    switch (day) {
      case 'Sunday':
        availableTimes.sunday = [TimeSlot(start: start, end: end)];
        break;
      case 'Monday':
        availableTimes.monday = [TimeSlot(start: start, end: end)];
        break;
      case 'Tuesday':
        availableTimes.tuesday = [TimeSlot(start: start, end: end)];
        break;
      case 'Wednesday':
        availableTimes.wednesday = [TimeSlot(start: start, end: end)];
        break;
      case 'Thursday':
        availableTimes.thursday = [TimeSlot(start: start, end: end)];
        break;
      case 'Friday':
        availableTimes.friday = [TimeSlot(start: start, end: end)];
        break;
      case 'Saturday':
        availableTimes.saturday = [TimeSlot(start: start, end: end)];
        break;
    }
  }

  Future<void> _pickImages(String type) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (result != null) {
      List<String> paths = result.paths.map((path) => path!).toList();
      setState(() {
        if (type == 'property') {
          propertyImages.addAll(paths);
        } else if (type == 'vehicle') {
          vehicleImages.addAll(paths);
        } else if (type == 'furniture') {
          furnitureImages.addAll(paths);
        }
      });
    }
  }

  Widget _buildImagePickerContainer(String type) {
    List<String> images;
    String label;
    if (type == 'property') {
      images = propertyImages;
      label = 'Add Property Photos';
    } else if (type == 'vehicle') {
      images = vehicleImages;
      label = 'Add Vehicle Photos';
    } else {
      images = furnitureImages;
      label = 'Add Furniture Photos';
    }

    return GestureDetector(
      onTap: () => _pickImages(type),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12.0),
        ),
        height: 150,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Icon(Icons.add_photo_alternate),
            if (images.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          images[index],
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget timesAvailableSection() {
    List<String> days = dayValues.keys.toList();

    return Column(
      children: [
        Text(
          'Availability for Visitors',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        for (String day in days)
          TimeSlotSection(
            day: day,
            dayValues: dayValues,
            onTimeSlotChanged: (String day, String start, String end) {
              _updateTimeSlot(day, start, end);
            },
            onDayCheckChanged: (String day) {
              _updateDay(day);
            },
          )
      ],
    );
  }

  Widget propertyForm(double screenWidth) {
    List<String> propertyTypes = [
      'Home',
      'Apartment',
      'Duplex',
      'Other',
    ];

    Widget gap = const SizedBox(height: 12);

    return SingleChildScrollView(
      child: Center(
        child: Form(
          key: _propertyFormKey,
          child: SizedBox(
            width: screenWidth / 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildImagePickerContainer('property'),
                gap,
                const Text('Property Type'),
                DropdownButtonFormField(
                  hint: const Text('Select a property type'),
                  items: propertyTypes
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {
                    if (value == null || value.isEmpty) return;
                    setState(() {
                      selectedPropertyType = value;
                    });
                  },
                ),
                gap,
                TextFormField(
                  controller: titleController,
                  cursorHeight: 16,
                  decoration: const InputDecoration(
                    label: Text('Listing Title'),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Required field';
                    return null;
                  },
                ),
                gap,
                TextFormField(
                  controller: bedroomController,
                  cursorHeight: 16,
                  decoration: const InputDecoration(
                    label: Text('Number of Bedrooms'),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^[0-9]+.?[0-9]*'),
                    )
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Required field';
                    return null;
                  },
                ),
                gap,
                TextFormField(
                  controller: bathroomController,
                  cursorHeight: 16,
                  decoration: const InputDecoration(
                    label: Text('Number of Bedrooms'),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^[0-9]+.?[0-9]*'),
                    )
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Required field';
                    return null;
                  },
                ),
                gap,
                TextFormField(
                  controller: priceController,
                  cursorHeight: 16,
                  maxLength: 10,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  decoration: const InputDecoration(
                    label: Text('Price'),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^[0-9]+.?[0-9]*'),
                    )
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Required field';
                    return null;
                  },
                ),
                gap,
                TextFormField(
                  controller: streetAddressController,
                  cursorHeight: 16,
                  maxLength: 32,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  decoration: const InputDecoration(
                    label: Text('Street Address'),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Required field';
                    return null;
                  },
                ),
                gap,
                TextFormField(
                  controller: cityController,
                  cursorHeight: 16,
                  maxLength: 32,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  decoration: const InputDecoration(
                    label: Text('City'),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Required field';
                    return null;
                  },
                ),
                gap,
                TextFormField(
                  controller: stateController,
                  cursorHeight: 16,
                  maxLength: 2,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  decoration: const InputDecoration(
                    label: Text('State (code)'),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Required field';
                    return null;
                  },
                ),
                gap,
                TextFormField(
                  controller: zipCodeController,
                  cursorHeight: 16,
                  maxLength: 5,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  decoration: const InputDecoration(
                    label: Text('Zip Code'),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Required field';
                    return null;
                  },
                ),
                gap,
                TextFormField(
                  controller: descriptionController,
                  cursorHeight: 16,
                  maxLines: 10,
                  minLines: 5,
                  maxLength: 1000,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  decoration: const InputDecoration(
                    label: Text('Description'),
                    alignLabelWithHint: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Required field';
                    return null;
                  },
                ),
                gap,
                timesAvailableSection(),
                const SizedBox(height: 32),
                FilledButton(
                  onPressed: () {
                    if (_propertyFormKey.currentState!.validate()) {
                      final propertyListing = PropertyListing(
                        id: const Uuid().v4(),
                        username: 'Dylan W.',
                        userEmail: 'dy@gmail.com',
                        dateCreated:
                            DateTime.now().subtract(const Duration(days: 4)),
                        lastUpdated:
                            DateTime.now().subtract(const Duration(hours: 36)),
                        mainImageUrl: 'https://picsum.photos/id/10/300/300',
                        title:
                            '${titleController.text} - [$selectedPropertyType]',
                        price: int.tryParse(priceController.text) ?? 0,
                        location: Location(
                          longitude: -118.264854,
                          latitude: 34.077164,
                          streetAddress: streetAddressController.text,
                          city: cityController.text,
                          stateCode: stateController.text,
                          stateName: stateController.text,
                          zipCode: int.tryParse(zipCodeController.text) ?? 0,
                        ),
                        description: descriptionController.text,
                        bedroomCount: int.tryParse(bedroomController.text) ?? 0,
                        bathroomCount:
                            int.tryParse(bathroomController.text) ?? 0,
                        imageUrls: propertyImages,
                        availableTimes: availableTimes,
                      );

                      ref.read(propertyProvider).add(propertyListing);
                      Navigator.pushNamed(context, propertyRoute);
                    }
                  },
                  style: FilledButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black87,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(0),
                      ),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text('Create Listing'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget vehicleForm(double screenWidth) {
    Widget gap = const SizedBox(height: 12);

    return SingleChildScrollView(
      child: Center(
        child: Form(
          key: _vehicleFormKey,
          child: SizedBox(
            width: screenWidth / 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildImagePickerContainer('vehicle'),
                gap,
                TextFormField(
                  controller: titleController,
                  cursorHeight: 16,
                  decoration: const InputDecoration(
                    label: Text('Listing Title'),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Required field';
                    return null;
                  },
                ),
                gap,
                TextFormField(
                  controller: mileageController,
                  cursorHeight: 16,
                  decoration: const InputDecoration(
                    label: Text('Mileage'),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^[0-9]+.?[0-9]*'),
                    )
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Required field';
                    return null;
                  },
                ),
                gap,
                TextFormField(
                  controller: priceController,
                  cursorHeight: 16,
                  maxLength: 10,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  decoration: const InputDecoration(
                    label: Text('Price'),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^[0-9]+.?[0-9]*'),
                    )
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Required field';
                    return null;
                  },
                ),
                gap,
                TextFormField(
                  controller: streetAddressController,
                  cursorHeight: 16,
                  maxLength: 32,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  decoration: const InputDecoration(
                    label: Text('Street Address'),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Required field';
                    return null;
                  },
                ),
                gap,
                TextFormField(
                  controller: cityController,
                  cursorHeight: 16,
                  maxLength: 32,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  decoration: const InputDecoration(
                    label: Text('City'),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Required field';
                    return null;
                  },
                ),
                gap,
                TextFormField(
                  controller: stateController,
                  cursorHeight: 16,
                  maxLength: 2,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  decoration: const InputDecoration(
                    label: Text('State (code)'),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Required field';
                    return null;
                  },
                ),
                gap,
                TextFormField(
                  controller: zipCodeController,
                  cursorHeight: 16,
                  maxLength: 5,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  decoration: const InputDecoration(
                    label: Text('Zip Code'),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Required field';
                    return null;
                  },
                ),
                gap,
                TextFormField(
                  controller: descriptionController,
                  cursorHeight: 16,
                  maxLines: 10,
                  minLines: 5,
                  maxLength: 1000,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  decoration: const InputDecoration(
                    label: Text('Description'),
                    alignLabelWithHint: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Required field';
                    return null;
                  },
                ),
                gap,
                timesAvailableSection(),
                const SizedBox(height: 32),
                FilledButton(
                  onPressed: () {
                    if (_vehicleFormKey.currentState!.validate()) {
                      final vehicleListing = VehicleListing(
                        id: const Uuid().v4(),
                        username: 'Dylan W.',
                        userEmail: 'dy@gmail.com',
                        dateCreated:
                            DateTime.now().subtract(const Duration(days: 4)),
                        lastUpdated:
                            DateTime.now().subtract(const Duration(hours: 36)),
                        mainImageUrl: 'https://picsum.photos/id/10/300/300',
                        title: titleController.text,
                        mileage: int.tryParse(mileageController.text) ?? 0,
                        price: int.tryParse(priceController.text) ?? 0,
                        location: Location(
                          longitude: -118.264854,
                          latitude: 34.077164,
                          streetAddress: streetAddressController.text,
                          city: cityController.text,
                          stateCode: stateController.text,
                          stateName: stateController.text,
                          zipCode: int.tryParse(zipCodeController.text) ?? 0,
                        ),
                        description: descriptionController.text,
                        imageUrls: vehicleImages,
                        availableTimes: availableTimes,
                      );

                      ref.read(vehiclesProvider).add(vehicleListing);
                      Navigator.pushNamed(context, vehiclesRoute);
                    }
                  },
                  style: FilledButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black87,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(0),
                      ),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text('Create Listing'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget furnitureForm(double screenWidth) {
    Widget gap = const SizedBox(height: 12);

    return SingleChildScrollView(
      child: Center(
        child: Form(
          key: _furnitureFormKey,
          child: SizedBox(
            width: screenWidth / 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildImagePickerContainer('furniture'),
                gap,
                TextFormField(
                  controller: titleController,
                  cursorHeight: 16,
                  decoration: const InputDecoration(
                    label: Text('Listing Title'),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Required field';
                    return null;
                  },
                ),
                gap,
                TextFormField(
                  controller: conditionController,
                  cursorHeight: 16,
                  decoration: const InputDecoration(
                    label: Text('Condition'),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Required field';
                    return null;
                  },
                ),
                gap,
                TextFormField(
                  controller: priceController,
                  cursorHeight: 16,
                  maxLength: 10,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  decoration: const InputDecoration(
                    label: Text('Price'),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^[0-9]+.?[0-9]*'),
                    )
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Required field';
                    return null;
                  },
                ),
                gap,
                TextFormField(
                  controller: streetAddressController,
                  cursorHeight: 16,
                  maxLength: 32,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  decoration: const InputDecoration(
                    label: Text('Street Address'),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Required field';
                    return null;
                  },
                ),
                gap,
                TextFormField(
                  controller: cityController,
                  cursorHeight: 16,
                  maxLength: 32,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  decoration: const InputDecoration(
                    label: Text('City'),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Required field';
                    return null;
                  },
                ),
                gap,
                TextFormField(
                  controller: stateController,
                  cursorHeight: 16,
                  maxLength: 2,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  decoration: const InputDecoration(
                    label: Text('State (code)'),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Required field';
                    return null;
                  },
                ),
                gap,
                TextFormField(
                  controller: zipCodeController,
                  cursorHeight: 16,
                  maxLength: 5,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  decoration: const InputDecoration(
                    label: Text('Zip Code'),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Required field';
                    return null;
                  },
                ),
                gap,
                TextFormField(
                  controller: descriptionController,
                  cursorHeight: 16,
                  maxLines: 10,
                  minLines: 5,
                  maxLength: 1000,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  decoration: const InputDecoration(
                    label: Text('Description'),
                    alignLabelWithHint: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Required field';
                    return null;
                  },
                ),
                gap,
                timesAvailableSection(),
                const SizedBox(height: 32),
                FilledButton(
                  onPressed: () {
                    if (_furnitureFormKey.currentState!.validate()) {
                      final furnitureListing = FurnitureListing(
                        id: const Uuid().v4(),
                        username: 'Dylan W.',
                        userEmail: 'dy@gmail.com',
                        dateCreated:
                            DateTime.now().subtract(const Duration(days: 4)),
                        lastUpdated:
                            DateTime.now().subtract(const Duration(hours: 36)),
                        mainImageUrl: 'https://picsum.photos/id/10/300/300',
                        title: titleController.text,
                        condition: conditionController.text,
                        price: int.tryParse(priceController.text) ?? 0,
                        location: Location(
                          longitude: -118.264854,
                          latitude: 34.077164,
                          streetAddress: streetAddressController.text,
                          city: cityController.text,
                          stateCode: stateController.text,
                          stateName: stateController.text,
                          zipCode: int.tryParse(zipCodeController.text) ?? 0,
                        ),
                        description: descriptionController.text,
                        imageUrls: furnitureImages,
                        availableTimes: availableTimes,
                      );

                      ref.read(furnitureProvider).add(furnitureListing);
                      Navigator.pushNamed(context, furnitureRoute);
                    }
                  },
                  style: FilledButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black87,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(0),
                      ),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text('Create Listing'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget forms(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: DefaultTabController(
        length: 3,
        child: SizedBox(
          width: screenWidth / 3,
          child: Column(
            children: [
              const TabBar(
                indicatorColor: Colors.black87,
                labelColor: Colors.black87,
                tabs: [
                  Tab(text: 'Property'),
                  Tab(text: 'Vehicle'),
                  Tab(text: 'Furniture'),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 1000,
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    propertyForm(screenWidth),
                    vehicleForm(screenWidth),
                    furnitureForm(screenWidth),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            MainAppBar(route: ModalRoute.of(context)?.settings.name ?? ''),
            SliverFillRemaining(
              child: ListView(
                children: [
                  SizedBox(
                    height: 600,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: 600,
                          width: double.infinity,
                          child: Image.asset(
                            'assets/images/background.jpg',
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Text(
                              'We allow shoppers to send our trusted partners to view listings for them.',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  forms(context),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
