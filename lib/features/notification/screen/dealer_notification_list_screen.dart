import 'package:assignment_abybaby/core/utils/app_settings.dart';
import 'package:assignment_abybaby/features/notification/widget/logout_dialog.dart';
import 'package:assignment_abybaby/features/notification/widget/notification_card.dart';
import 'package:assignment_abybaby/route/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/dealer/dealer_bloc.dart';
import '../../../domain/dealer/dealer_event.dart';
import '../../../domain/dealer/dealer_state.dart';

class DealerNotificationListScreen extends StatefulWidget {
  const DealerNotificationListScreen({super.key});

  @override
  State<DealerNotificationListScreen> createState() =>
      _DealerNotificationListScreenState();
}

class _DealerNotificationListScreenState
    extends State<DealerNotificationListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_){
      context.read<DealerBloc>().add(const FetchDealerNotifications());
    _scrollController.addListener(_onScroll);
    });

  }

  void _onScroll() {
    if (_isBottom) {
      context.read<DealerBloc>().add(LoadMoreDealerNotifications());
    }
  }

  bool get _isBottom {

    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Dealer Notifications",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () {
              LogoutDialog().showLogoutDialog(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh:() async {
          context.read<DealerBloc>().add(const FetchDealerNotifications());
        },
        child: BlocBuilder<DealerBloc, DealerState>(
          builder: (context, state) {
            final notifications = state.notifications;

            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (notifications.isEmpty) {
              return Center(child: Text("No Dealer Found"),);
            }

            return ListView.separated(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length + (state.isLoadingMore ? 1 : 0),
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                if (index >= notifications.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final item = notifications[index];
                return NotificationCard(notification: item);
              },
            );
          },
        ),
      ),
    );
  }
}
