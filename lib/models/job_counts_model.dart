// To parse this JSON data, do
//
//     final jobCounts = jobCountsFromJson(jsonString);

import 'dart:convert';

JobCounts jobCountsFromJson(String str) => JobCounts.fromJson(json.decode(str));

String jobCountsToJson(JobCounts data) => json.encode(data.toJson());

class JobCounts {
  final int? jobsPosted;
  final int? jobsHiredFor;

  JobCounts({
    this.jobsPosted,
    this.jobsHiredFor,
  });

  factory JobCounts.fromJson(Map<String, dynamic> json) => JobCounts(
        jobsPosted: json["jobsPosted"],
        jobsHiredFor: json["jobsHiredFor"],
      );

  Map<String, dynamic> toJson() => {
        "jobsPosted": jobsPosted,
        "jobsHiredFor": jobsHiredFor,
      };
}
