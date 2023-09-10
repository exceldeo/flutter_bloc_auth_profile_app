// {
//   "name": "John Doe",
//   "birthday": "1990-01-01",
//   "height": 170,
//   "weight": 70,
//   "interests": [
//     "football",
//     "basketball"
//   ],
// }

class ProfileModel {
  final String name;
  final String birthday;
  final int height;
  final int weight;
  final List<String> interests;

  const ProfileModel(
      this.name, this.birthday, this.height, this.weight, this.interests);

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      json['name'],
      json['birthday'],
      json['height'],
      json['weight'],
      json['interests'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "birthday": birthday,
      "height": height,
      "weight": weight,
      "interests": interests,
    };
  }
}
