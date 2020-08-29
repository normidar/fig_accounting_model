part of fig_accounting_model;

class AccountSystem {
  Future initDatabase()async {
    //存放总数的表结构
    TableStru tableStru = TableStru('accounting_overflow');
    tableStru.addType('account_name', FieldStr(nullAllow: false));
    tableStru.addType('count',FieldDecimal(10, 0));
    //存放流动的表结构
    TableStru steamTableStru = TableStru('accounting_steam');
    steamTableStru.addType('form', FieldStr(nullAllow: false));
    steamTableStru.addType('to', FieldStr(nullAllow: false));
    steamTableStru.addType('count',FieldDecimal(10,0));
    steamTableStru.addType('date',FieldDate());
  }
}
