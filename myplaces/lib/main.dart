import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:myplaces/placeslocations.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyPlacesApp(),
    );
  }
}

class MyPlacesApp extends StatefulWidget {
  const MyPlacesApp({super.key});
  @override
  State<MyPlacesApp> createState() => MyPlacesAppPage();
}

class MyPlacesAppPage extends State<MyPlacesApp> {
  List<dynamic> placesData = [];
  String stats = 'Please enter the place to see the details.';
  String place = '';
  String defaultplace = 'Petronas Twin Towers';
  Placeslocations placeslocations = Placeslocations();
  bool load = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Places Application'),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            ),
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: Center(
            child: SizedBox(
              width : 700,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          hintText: 'Select a Place',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      items: placeslocations.placesname.map((String place) {
                        return DropdownMenuItem<String>(
                          // showing all the places in the drop down menu
                          value: place,
                          child: Text(place),
                        );
                      }).toList(),

                      // to change the box to display the selected place
                      onChanged: (String? newvalue) {
                        setState(() {
                          defaultplace = newvalue!;
                        });
                      }
                    ),
                  ),

                  SizedBox(
                    width : 200,
                    height: 50,
                    child : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      // to send the selected place to the method to get and display its details
                      onPressed: getplaces,
                      child: Text(
                        'Place Details',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      

                    ),
                  ),

                  SizedBox(height: 30),

                  // loading indicator visibility
                  Visibility(visible: load,child: CircularProgressIndicator(),),

                  SizedBox(height: 30),
                  
                  placesData.isEmpty
                    ? Center(child : Text(stats))
                    : Expanded(
                        child : ListView.builder(
                          itemCount: placesData.length,
                          itemBuilder: (context, index){

                            // getting each place item as a map
                            final placeItem = placesData[index] as Map<String, dynamic>;
                            // extracting all the details from the map
                            String id = placesData[index]['id']?.toString() ?? 'N/A';
                            String name = placesData[index]['name'] ?? 'N/A';
                            String state = placesData[index]['state'] ?? 'N/A';
                            String category = placesData[index]['category'] ?? 'N/A';
                            String description = placesData[index]['description'] ?? 'N/A';
                            String imageUrl = placesData[index]['image_url'] ?? '';
                            String latitude = placesData[index]['latitude']?.toString() ?? 'N/A';
                            String longitude = placesData[index]['longitude']?.toString() ?? 'N/A';
                            String contact = placesData[index]['contact'] ?? 'N/A';
                            String rating = placesData[index]['rating']?.toString() ?? 'N/A';

                            return Card(
                              child : InkWell(
                                onTap: ()
                                {
                                  showDialog(
                                    context: context,
                                     builder: (context) {
                                      return AlertDialog(
                                        title: Text('Details of $name'),
                                        
                                        content : Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Image.network(
                                              imageUrl,
                                              height: 150,
                                              width: 150,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error, stackTrace) {
                                                return Container
                                                (
                                                  width: 50,
                                                  height: 70,
                                                  color: Colors.grey,
                                                  child: Center(child : Text('No Image Found'),),
                                                );
                                              },
                                              ),
                                              SizedBox(height: 10),

                                              Text ('Name: $name'),
                                              SizedBox(height: 10),

                                              Text ('State: $state'),
                                              SizedBox(height: 10),

                                              Text ('Category: $category'),
                                              SizedBox(height: 10),

                                              Text ('Description: $description'),
                                              SizedBox(height: 10),

                                              Text ('Latitude : $latitude'),
                                              SizedBox(height: 10),

                                              Text ('Longitude : $longitude'),
                                              SizedBox(height: 10),

                                              Text ('Contact number : $contact'),
                                              SizedBox(height: 10),

                                              Text ('Rating : $rating'),
                                            ],
                                          ),

                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Close'),
                                          ),
                                        ],
                                      );
                                     }
                                  );
                                },

                                child: ListTile(
                                  leading: Image.network(
                                    imageUrl,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container
                                      (
                                        width: 50,
                                        height: 70,
                                        color: Colors.grey,
                                        child: Center(child : Text('No Image Found'),),
                                      );
                                    },
                                    ),
                                  title: Text(name),
                                  subtitle: Text('State: $state\nrating: $rating'),
                                ),

                              ),

                            );

                          }

                        )

                      )

                ],

              ),

            ),

        ),

      ),

    );

  }
  void getplaces() async {
    // start loading animation to receive deta from api
    setState(() {
      load = true;
      placesData = [];
      stats = 'Finding details for $defaultplace...'; 
    });

    // giving the url to the response to get the data from the api 
    String url = 'https://slumberjer.com/teaching/a251/locations.php?name=$defaultplace';
    
    // taking all the data in the api and put in a list
    List<dynamic> fetchedList = [];
    String newStats = '';

    try {
      final response = await http.get(
        Uri.parse(url))
      .timeout(Duration(
        seconds: 10)
      );

      // handeling error if any apper to occure during fetching data
      if (response.statusCode != 200) {
        newStats = 'Error: Failed to fetch data (Status ${response.statusCode}).';
      }
      
      // checking the body if it is empty
      else if (response.body.isEmpty) {
        newStats = 'Error: Empty response received from server.';
      } 
      
      else {
        // decode data from json format to dart format
        final data = json.decode(response.body);

        // check if the data is a map with 'locations' key or a list directly
        if (data is Map && data['locations'] is List) {
          fetchedList = data['locations'];
        } 
        else if (data is List) {
          fetchedList = data;
        } 
        else if (data is String) {
          newStats = 'For the Message: "$data". No details found for "$defaultplace".';
        }
        else {
          newStats = 'Error: Invalid data format received from the API.';
        }
        
        // filtering the list to only dislpay the data selected
        if (fetchedList.isNotEmpty) {
          List<dynamic> filteredList = fetchedList.where((placeMap) {
            // taking the only place tht have the same name as the selected place
            if (placeMap is Map && placeMap.containsKey('name')) {
              // making sure it is correct and make it much more neater to be compared
              return placeMap['name']?.toString().trim().toLowerCase() == defaultplace.trim().toLowerCase();
            }
            return false;
          }).toList();
          
          // subbing the filtered place to the fetched list to be only displayed
          fetchedList = filteredList;
        }
      }
      
    } 
    catch (e) { // to catch any exception that is possible to happen
      newStats = 'Error processing data: An exception occurred - ${e.toString()}';
    }
    setState(() {
      load = false; // turn off loading indicator

      // assigning the fetched list to the places data to be displayed
      placesData = fetchedList;

      if (placesData.isEmpty) {
         if (newStats.isEmpty) {
            stats = 'No data found for the place "$defaultplace".';
         } else {
            stats = newStats; 
         }
      } else {
        // celar the stats and only display the places data
        stats = ''; 
      }
    });
  }
}