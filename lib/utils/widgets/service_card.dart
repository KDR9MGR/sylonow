import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sylonow/data/models/service_model.dart';
import 'package:sylonow/utils/constants/app_colors.dart';

class ServiceCard extends ConsumerWidget {
  final ServiceModel service;
  final bool isGridView;

  const ServiceCard({
    super.key,
    required this.service,
    this.isGridView = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (isGridView) {
      return _buildGridCard(context);
    }
    return _buildListCard(context);
  }

  Widget _buildGridCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: const Color(0xFFEFEFEF),
          width: 1.2,
        ),
      ),
      child: InkWell(
        onTap: () {
          context.push('/service-detail');
        },
        borderRadius: BorderRadius.circular(15.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15.r)),
              child: AspectRatio(
                aspectRatio: 1.2,
                child: Image.network(
                  service.images.first,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[200],
                    child: Icon(Icons.image_not_supported, size: 24.sp),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1A1D26),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₹${service.price.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: TColors.primary,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 14.sp,
                            color: const Color(0xFFFED060),
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            '${service.rating}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    service.description,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black87,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListCard(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 119.h,
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: const Color(0xFFEFEFEF),
          width: 1.2,
        ),
      ),
      child: InkWell(
        onTap: () {
          context.push('/service-detail');
        },
        borderRadius: BorderRadius.circular(15.r),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 117.w,
              height: 117.h,
              decoration: BoxDecoration(
                color: const Color(0xFFFFD9EC),
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: Image.network(
                  service.images.first,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[200],
                    child: Icon(Icons.image_not_supported, size: 24.sp),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(14.w, 8.h, 12.w, 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1A1D26),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₹${service.price.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: TColors.primary,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 16.sp,
                              color: const Color(0xFFFED060),
                            ),
                            SizedBox(width: 3.w),
                            Text(
                              '${service.rating} (${service.reviewCount})',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Expanded(
                      child: Text(
                        service.description,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black87,
                          height: 1.3,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
