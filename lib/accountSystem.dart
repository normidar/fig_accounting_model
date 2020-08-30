part of fig_accounting_model;

///此应用有几个功能:
///最大的功能是插入金钱流动数据到数据库
///每次插入都会同时对两个数据表进行更改
///插入一条'流动'到数据表2
///更改数据表1为重和
class AccountSystem {
  String totalTableName = "accounting_total";
  DataLinkerSqlite linker;
  List<TableStru> _getInitDataStrus() {
    List<TableStru> rt = [];
    //存放总数的表结构
    TableStru tableStru = TableStru(totalTableName);
    tableStru.addType('account_name', FieldStr(nullAllow: false, unique: true));
    tableStru.addType('count', FieldDecimal(10, 0));
    //存放流动的表结构
    TableStru steamTableStru = TableStru('accounting_steams');
    steamTableStru.addType('form', FieldStr(nullAllow: false));
    steamTableStru.addType('to', FieldStr(nullAllow: false));
    steamTableStru.addType('count', FieldDecimal(10, 0));
    steamTableStru.addType('date', FieldDate());
    //添加到返回中
    rt.add(tableStru);
    rt.add(steamTableStru);
    return rt;
  }

  Future _createInitTables() async {
    //初始化数据库连接
    var card = LinkSets(host: 'lig_database');
    linker = DataLinkerSqlite(card);
    await linker.getConn();
    //创建数据表
    var tableStrus = _getInitDataStrus();
    for (var i in tableStrus) {
      linker.createTable(i);
    }
    //...
  }

  ///初始化数据库
  Future initTables() async {
    await _createInitTables();
  }

  ///
  Future insertStream(String _form, String _to, double count, {DateTime date}) {
    if (date == null) date = DateTime.now();
    linker.addDataToTable('accounting_steams', [
      {'form': _form, 'to': _to, 'count': count, 'date': date.toString()}
    ]);
  }

  ///更新会计汇总
  Future _updateTotals(String _form, String _to, double count) {}

  ///增减会计元素,内附检测,若没有则创建
  Future _addTatals(String where, double count) {}

  ///检测是否有该会计元素
  Future<bool> _checkTotal(String where) async {
    var result = await linker.getRows("SELECT * FROM " +
        totalTableName +
        " WHERE account_name = '" +
        where +
        "'");
    if (result.length > 0)
      return true;
    else
      return false;
  }
}
