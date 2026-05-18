import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:parkliapp/app_data.dart';
import 'package:parkliapp/core/services/app_session_service.dart';

class MyViolationsScreen extends StatefulWidget {
  const MyViolationsScreen({super.key});

  @override
  State<MyViolationsScreen> createState() => _MyViolationsScreenState();
}

class _MyViolationsScreenState extends State<MyViolationsScreen> {
  final AppSessionService _appSessionService = AppSessionService();

  late final Future<AppUserSession?> _sessionFuture;

  @override
  void initState() {
    super.initState();
    _sessionFuture = _appSessionService.getCurrentSession();
  }

  Future<void> _payViolation(Map<String, dynamic> violation) async {
    try {
      await Supabase.instance.client.from('violations').update({
        'status': 'paid',
        'paid_at': DateTime.now().toUtc().toIso8601String(),
      }).eq('id', violation['id']);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppData.translate(
              'Violation paid successfully',
              'تم سداد المخالفة بنجاح',
            ),
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppData.translate(
              'Failed to pay violation',
              'فشل سداد المخالفة',
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: AppData.isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Color(0xFF414141),
              size: 20,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            AppData.translate('My Violations', 'مخالفاتي المرورية'),
            style: const TextStyle(
              color: Color(0xFF2A2A2A),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
        ),
        body: _buildViolationsList(),
      ),
    );
  }

  Widget _buildViolationsList() {
    final supabase = Supabase.instance.client;

    return FutureBuilder<AppUserSession?>(
      future: _sessionFuture,
      builder: (context, sessionSnapshot) {
        if (sessionSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF237D8C),
            ),
          );
        }

        final session = sessionSnapshot.data;

        if (session == null) {
          return Center(
            child: Text(
              AppData.translate(
                'Please login to view violations',
                'يرجى تسجيل الدخول لعرض المخالفات',
              ),
              textAlign: TextAlign.center,
            ),
          );
        }

        return StreamBuilder<List<Map<String, dynamic>>>(
          stream: supabase
              .from('violations')
              .stream(primaryKey: ['id']).eq('user_id', session.userId),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                  textAlign: TextAlign.center,
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF237D8C),
                ),
              );
            }

            final violations = snapshot.data ?? [];

            if (violations.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.assignment_turned_in_rounded,
                      size: 80,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(height: 15),
                    Text(
                      AppData.translate(
                        'No violations found.',
                        'لا توجد مخالفات مسجلة.',
                      ),
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: violations.length,
              itemBuilder: (context, index) {
                final v = violations[index];

                final createdAt = v['created_at']?.toString() ?? '';
                final dateText = createdAt.length >= 10
                    ? createdAt.substring(0, 10)
                    : createdAt;

                final isPaid = (v['status'] ?? 'unpaid') == 'paid';
                final amount = v['amount'] ?? 0;

                return Card(
                  margin: const EdgeInsets.only(bottom: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: isPaid
                                  ? const Color(0xFFE8F5E9)
                                  : const Color(0xFFFFEBEE),
                              child: Icon(
                                isPaid
                                    ? Icons.check_circle
                                    : Icons.report_problem,
                                color: isPaid ? Colors.green : Colors.red,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                v['violation_type'] ??
                                    AppData.translate('Violation', 'مخالفة'),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Text(
                              "$amount SAR",
                              style: TextStyle(
                                color: isPaid ? Colors.green : Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          dateText,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: isPaid ? null : () => _payViolation(v),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isPaid
                                  ? Colors.grey
                                  : const Color(0xFF237D8C),
                              disabledBackgroundColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              isPaid
                                  ? AppData.translate('Paid', 'مدفوعة')
                                  : AppData.translate(
                                      'Pay Fine', 'سداد المخالفة'),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
