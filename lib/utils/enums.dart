// function to return the string value of enum
String enumToString<T>(T enumValue) => enumValue.toString().split('.').last;

// Function to get user type values as strings
List<String> getUserTypeValues() {
  return UserType.values.map((e) => enumToString(e)).toList(growable: false);
}

// Function to get city values as strings
List<String> getCityValues() {
  return City.values.map((e) => enumToString(e)).toList(growable: false);
}

// Function to get task category values as strings
List<String> getTaskCategoryValues() {
  return TaskCategory.values
      .map((e) => enumToString(e))
      .toList(growable: false);
}

// Enum for user types
enum UserType {
  customer,
  provider,
}

// enum for service calls location
enum City {
  haifa,
  ashdod,
  ashkelon,
  hertzeliya,
}

// enum for service calls category
enum TaskCategory {
  plumbering,
  babysitting,
  dogwalker,
  etc,
}
