import 'package:flutter/material.dart';

class TechFest extends StatelessWidget {
  const TechFest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TechFest",
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const RegistrationPage(),
    );
  }
}

// --------------------------------------------------
// REGISTRATION PAGE
// --------------------------------------------------

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController nameController = TextEditingController();

  String department = "Computer";
  String eventName = "Coding Competition";

  bool tech = false;
  bool nonTech = false;

  DateTime? selectedDateTime;

  double fees = 100;

  // Date and Time Picker
  Future<void> selectDateTime() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (date == null) return;

    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) return;

    setState(() {
      selectedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  void register() {
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter participant name")),
      );
      return;
    }

    if (!tech && !nonTech) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select Tech or Non-Tech")),
      );
      return;
    }

    if (selectedDateTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select event date and time")),
      );
      return;
    }

    // Open Tab View
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EventTabPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "TechFest Registration",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Icon(Icons.computer, size: 80, color: Colors.blue),
            ),

            const SizedBox(height: 15),

            const Center(
              child: Text(
                "TECHFEST 2026",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 30),

            // PARTICIPANT NAME
            const Text(
              "Participant Name",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Enter participant name",
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // DEPARTMENT
            const Text(
              "Department",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            RadioListTile<String>(
              title: const Text("Computer"),
              value: "Computer",
              groupValue: department,
              onChanged: (value) {
                setState(() {
                  department = value!;
                });
              },
            ),

            RadioListTile<String>(
              title: const Text("IT"),
              value: "IT",
              groupValue: department,
              onChanged: (value) {
                setState(() {
                  department = value!;
                });
              },
            ),

            RadioListTile<String>(
              title: const Text("Mechanical"),
              value: "Mechanical",
              groupValue: department,
              onChanged: (value) {
                setState(() {
                  department = value!;
                });
              },
            ),

            RadioListTile<String>(
              title: const Text("Civil"),
              value: "Civil",
              groupValue: department,
              onChanged: (value) {
                setState(() {
                  department = value!;
                });
              },
            ),

            const SizedBox(height: 10),

            // EVENT TYPE
            const Text(
              "Event Type",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            CheckboxListTile(
              title: const Text("Tech Event"),
              value: tech,
              onChanged: (value) {
                setState(() {
                  tech = value!;
                });
              },
            ),

            CheckboxListTile(
              title: const Text("Non-Tech Event"),
              value: nonTech,
              onChanged: (value) {
                setState(() {
                  nonTech = value!;
                });
              },
            ),

            const SizedBox(height: 15),

            // EVENT NAME
            const Text(
              "Event Name",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              value: eventName,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: const Icon(Icons.event),
              ),
              items: const [
                DropdownMenuItem(
                  value: "Coding Competition",
                  child: Text("Coding Competition"),
                ),
                DropdownMenuItem(value: "Robotics", child: Text("Robotics")),
                DropdownMenuItem(
                  value: "Quiz Competition",
                  child: Text("Quiz Competition"),
                ),
                DropdownMenuItem(value: "Gaming", child: Text("Gaming")),
              ],
              onChanged: (value) {
                setState(() {
                  eventName = value!;
                });
              },
            ),

            const SizedBox(height: 25),

            // DATE TIME
            const Text(
              "Event Date & Time",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: selectDateTime,
                icon: const Icon(Icons.calendar_month),
                label: Text(
                  selectedDateTime == null
                      ? "Select Date & Time"
                      : "${selectedDateTime!.day}/"
                            "${selectedDateTime!.month}/"
                            "${selectedDateTime!.year} "
                            "${selectedDateTime!.hour}:"
                            "${selectedDateTime!.minute}",
                ),
              ),
            ),

            const SizedBox(height: 25),

            // FEES SLIDER
            Text(
              "Fees: ₹${fees.toInt()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            Slider(
              value: fees,
              min: 50,
              max: 500,
              divisions: 9,
              label: "₹${fees.toInt()}",
              onChanged: (value) {
                setState(() {
                  fees = value;
                });
              },
            ),

            const SizedBox(height: 25),

            // REGISTER BUTTON
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: register,
                child: const Text(
                  "REGISTER",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// --------------------------------------------------
// TAB VIEW
// --------------------------------------------------

class EventTabPage extends StatelessWidget {
  const EventTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,

      child: Scaffold(
        appBar: AppBar(
          title: const Text("TechFest Events"),

          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.grid_view), text: "All Events"),
              Tab(icon: Icon(Icons.code), text: "Event 1"),
              Tab(icon: Icon(Icons.smart_toy), text: "Event 2"),
            ],
          ),
        ),

        body: const TabBarView(
          children: [AllEvents(), Event1Details(), Event2Details()],
        ),
      ),
    );
  }
}

// --------------------------------------------------
// TAB 1 - ALL EVENTS
// --------------------------------------------------

class AllEvents extends StatelessWidget {
  const AllEvents({super.key});

  final List<Map<String, String>> events = const [
    {
      "name": "Coding Competition",
      "image": "https://images.unsplash.com/photo-1515879218367-8466d910aaa4",
    },
    {
      "name": "Robotics",
      "image": "https://images.unsplash.com/photo-1485827404703-89b55fcc595e",
    },
    {
      "name": "Quiz Competition",
      "image": "https://images.unsplash.com/photo-1606326608606-aa0b62935f2b",
    },
    {
      "name": "Gaming",
      "image": "https://images.unsplash.com/photo-1542751371-adc38448a05e",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),

      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.8,
      ),

      itemCount: events.length,

      itemBuilder: (context, index) {
        return Card(
          elevation: 5,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),

          clipBehavior: Clip.antiAlias,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Expanded(
                child: Image.network(
                  events[index]["image"]!,
                  width: double.infinity,
                  fit: BoxFit.cover,

                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.image, size: 80);
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10),

                child: Text(
                  events[index]["name"]!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// --------------------------------------------------
// TAB 2 - EVENT 1
// --------------------------------------------------

class Event1Details extends StatelessWidget {
  const Event1Details({super.key});

  final List<String> images = const [
    "https://images.unsplash.com/photo-1515879218367-8466d910aaa4",
    "https://images.unsplash.com/photo-1555066931-4365d14bab8c",
    "https://images.unsplash.com/photo-1461749280684-dccba630e2f6",
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const Padding(
            padding: EdgeInsets.all(16),

            child: Text(
              "Coding Competition",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),

          SizedBox(
            height: 250,

            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,

              itemBuilder: (context, index) {
                return Container(
                  width: 330,
                  margin: const EdgeInsets.symmetric(horizontal: 8),

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),

                    child: Image.network(images[index], fit: BoxFit.cover),
                  ),
                );
              },
            ),
          ),

          const Padding(
            padding: EdgeInsets.all(16),

            child: Text(
              "Event Description",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),

            child: Text(
              "Coding Competition is a technical event "
              "where participants solve programming problems "
              "using logical thinking and coding skills. "
              "Participants can use languages such as "
              "C, C++, Java, Python and Dart. "
              "The event tests problem solving, algorithms "
              "and programming knowledge.",
              style: TextStyle(fontSize: 16, height: 1.6),
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

// --------------------------------------------------
// TAB 3 - EVENT 2
// --------------------------------------------------

class Event2Details extends StatelessWidget {
  const Event2Details({super.key});

  final List<String> images = const [
    "https://images.unsplash.com/photo-1485827404703-89b55fcc595e",
    "https://images.unsplash.com/photo-1535378917042-10a22c95931a",
    "https://images.unsplash.com/photo-1561144257-e32e1c9a7f6c",
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const Padding(
            padding: EdgeInsets.all(16),

            child: Text(
              "Robotics Competition",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),

          SizedBox(
            height: 250,

            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,

              itemBuilder: (context, index) {
                return Container(
                  width: 330,
                  margin: const EdgeInsets.symmetric(horizontal: 8),

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),

                    child: Image.network(images[index], fit: BoxFit.cover),
                  ),
                );
              },
            ),
          ),

          const Padding(
            padding: EdgeInsets.all(16),

            child: Text(
              "Event Description",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),

            child: Text(
              "Robotics Competition is an exciting technical "
              "event where participants design and build "
              "robots to complete different challenges. "
              "Participants demonstrate their creativity, "
              "electronics knowledge, programming skills "
              "and engineering concepts. "
              "The team completing the challenge "
              "successfully in the shortest time wins.",
              style: TextStyle(fontSize: 16, height: 1.6),
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
