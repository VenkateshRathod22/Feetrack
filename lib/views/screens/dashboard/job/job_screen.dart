import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/screens/dashboard/job/widget/ai_top_section.dart';

class JobScreen extends StatelessWidget {
  const JobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // // AI top section
              const AiTopSection(),

              SizedBox(height: 20.h),

              // Job content starts here
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      "Top AI Matches",
                    ),

                    SizedBox(height: 12.h),

                    // Add your job cards here
                    _jobCard(
                      title: "Fintech Product Manager",
                      company: "Finova Solutions",
                      location: "Bengaluru",
                      salary: "₹18–24 LPA",
                      match: "94% Match",
                    ),

                    SizedBox(height: 12.h),

                    _jobCard(
                      title: "Frontend Developer",
                      company: "Codepeak Labs",
                      location: "Bengaluru",
                      salary: "₹10–16 LPA",
                      match: "92% Match",
                    ),

                    SizedBox(height: 12.h),

                    _jobCard(
                      title: "Growth Lead",
                      company: "Growvista",
                      location: "Mumbai",
                      salary: "₹15–22 LPA",
                      match: "90% Match",
                    ),

                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _jobCard({
    required String title,
    required String company,
    required String location,
    required String salary,
    required String match,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10.r,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 52.w,
            height: 52.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFF1554C0),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Text(
              title.isNotEmpty ? title[0] : "",
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF101828),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  company,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: const Color(0xFF667085),
                  ),
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 15.sp,
                      color: const Color(0xFF98A2B3),
                    ),
                    SizedBox(width: 3.w),
                    Text(
                      location,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF667085),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                salary,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF16803C),
                ),
              ),
              SizedBox(height: 6.h),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 5.h,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F7EE),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  match,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF16803C),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
