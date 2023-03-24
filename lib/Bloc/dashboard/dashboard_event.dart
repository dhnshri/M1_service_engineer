abstract class DashboardEvent {}

class GetDashboardCount extends DashboardEvent {

  String serviceUserId;

  GetDashboardCount({required this.serviceUserId});

}

class GetJobWorkDashboardCount extends DashboardEvent {

  String serviceUserId;

  GetJobWorkDashboardCount({required this.serviceUserId});

}

class GetTransportDashboardCount extends DashboardEvent {

  String serviceUserId;

  GetTransportDashboardCount({required this.serviceUserId});

}
