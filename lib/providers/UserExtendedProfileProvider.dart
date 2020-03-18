import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum GenderOption { MALE, FEMALE, OTHER }

extension GenderOptionValue on GenderOption {
  static const values = {
    GenderOption.MALE: "Male",
    GenderOption.FEMALE: "Female",
    GenderOption.OTHER: "Other"
  };

  String get value => values[this];

  String get current => this.toString().split('.').last;
}

enum JobStatus {
  SELF_EMPLOYED,
  FULL_TIME_SALARY_OR_WAGE_EARNER,
  PART_TIME_SALARY_OR_WAGE_EARNER,
  RETIRED,
  FULL_TIME_HOME_MAKER,
  UNEMPLOYED,
  CASUAL_FULL_TIME,
  CASUAL_PART_TIME,
  OTHER_BENEFICIARY
}

extension JobStatusValue on JobStatus {
  static const values = {
    JobStatus.SELF_EMPLOYED: "Self-employed",
    JobStatus.FULL_TIME_SALARY_OR_WAGE_EARNER: "Full-time salary or wage earner",
    JobStatus.PART_TIME_SALARY_OR_WAGE_EARNER: "Part-time salary or wage earner",
    JobStatus.RETIRED: "Retired",
    JobStatus.FULL_TIME_HOME_MAKER: "Full Time Home Maker",
    JobStatus.UNEMPLOYED: "Unemployed",
    JobStatus.CASUAL_FULL_TIME: "Casual full-time hours",
    JobStatus.CASUAL_PART_TIME: "Casual part-time hours",
    JobStatus.OTHER_BENEFICIARY: "Other beneficiary"
  };

  String get value => values[this];

  String get current => this.toString().split('.').last;
}

enum EducationLevel {
  BACHLORS_DEGREE,
  DEGREE_HIGHER_THAN_BACHELORS,
  TAFE_UNIVERSITY_COURSE_BELOW_BACHELORS_DEGREE,
  NATIONAL_CERTIFICATE_OR_TRADE_CERTIFICATE,
  OTHER_SCHOOL_QUALIFICATION,
  COMPLETED_HIGH_SCHOOL,
  NONE
}

extension EducationLevelValue on EducationLevel {
  static const values = {
    EducationLevel.BACHLORS_DEGREE: "Bachelor’s degree",
    EducationLevel.DEGREE_HIGHER_THAN_BACHELORS:
        "Degree higher than bachelor’s",
    EducationLevel.TAFE_UNIVERSITY_COURSE_BELOW_BACHELORS_DEGREE:
        "TAFE/university course below bachelor’s degree",
    EducationLevel.NATIONAL_CERTIFICATE_OR_TRADE_CERTIFICATE:
        "National Certificate or Trade Certificate",
    EducationLevel.OTHER_SCHOOL_QUALIFICATION:
        "Other school qualification (e.g. overseas school, Cambridge examination, A levels)",
    EducationLevel.COMPLETED_HIGH_SCHOOL: "Completed High School",
    EducationLevel.NONE: "None"
  };

  String get value => values[this];

  String get current => this.toString().split('.').last;
}

class UserExtendedProfileProvider with ChangeNotifier {
  double _weight, _height;

  EducationLevel _educationLevel;
  JobStatus _jobStatus;
  String _dob;
  GenderOption _gender;

  GenderOption get gender {
    return _gender;
  }

  set gender(GenderOption option) {
    _gender = option;
    notifyListeners();
  }

  EducationLevel get educationLevel {
    return _educationLevel;
  }

  set educationLevel(EducationLevel option) {
    _educationLevel = option;
    notifyListeners();
  }

  double get weight {
    return _weight;
  }

  set weight(double value) {
    _weight = value;
    notifyListeners();
  }

  double get height {
    return _height;
  }

  set height(double value) {
    _height = value;
    notifyListeners();
  }

  String get dateOfBirth {
    return _dob;
  }

  void setDateOfBirth(DateTime value) {
    _dob = DateFormat.yMd().format(value);
    notifyListeners();
  }

  JobStatus get jobStatus => _jobStatus;

  set jobStatus(JobStatus value) {
    _jobStatus = value;
    notifyListeners();
  }

  Map getAllDetails() {
    return {
      "weight": _weight,
      "height": _height,
      "educationLevel": _educationLevel.current,
      "jobStatus": _jobStatus.current,
      "dateOfBirth": _dob,
      "gender": _gender.current
    };
  }
}
