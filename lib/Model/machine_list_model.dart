class MachineList {
  int? id;
  String? machineName;
  String? quantity;



  MachineList({
    this.id,
    this.machineName,
    this.quantity,
  });

  MachineList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    machineName = json['machine_name'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['machine_name'] = this.machineName;
    data['quantity'] = this.quantity;
    return data;
  }

}