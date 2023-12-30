abstract class ApiUrl {
  static const baseUrl = "https://renttas.com/api/";
  static const imageurl = "https://renttas.com/";

  static const Login = "${baseUrl}login";
  static const register = "${baseUrl}registration";
  static const getPropertyUserID = "${baseUrl}property";
  static const createSubProperties = "${baseUrl}createSubProperties";
  static const saveTenant = "${baseUrl}addPropertyTenant";
  static const getTendentByIds = "${baseUrl}gettenantsbyid";
  static const createExpenses = "${baseUrl}addexpense";
  static const getExpenses = "${baseUrl}getExpenses";
  static const createDocument = "${baseUrl}createDocument";
  static const getDocument = "${baseUrl}getDocument";
  static const deleteDoc = "${baseUrl}deleteById/";
  static const deleteExp = "${baseUrl}deleteExpense/";
  static const saveBill = "${baseUrl}addPropertyBill";
  static const getBill = "${baseUrl}getbill";
  static const getBillByMobile = "${baseUrl}getBillByMobile";
  static const getDocByMobile = "${baseUrl}getDocByMobile";
  static const getDocComplteByMobile = "${baseUrl}getDocCompleteByMobile";
  static const createProperties = "${baseUrl}addProperty";
  static const forgetpaswd = "${baseUrl}forgetpaswd";
  static const addrecivedpayment = "${baseUrl}addrecivedpayment";
  static const deletebill = "${baseUrl}deletebill";
  static const deletedoc = "${baseUrl}deletedocid";
  static const getaddressdetails = "${baseUrl}getaddressdetails";
  static const addaddressdetails = "${baseUrl}addaddressdetails";
  static const getdocumentinabout = "${baseUrl}getdocumentinabout";
  static const adddocumentinabout = "${baseUrl}adddocumentinabout";
  static const deletetenant = "${baseUrl}deletetenant";
  static const updatetenant = "${baseUrl}updatetenant";

  //commercial
  static const addcompany = "${baseUrl}addcompany";
  static const getcompany = "${baseUrl}getcompany";
  static const deletecompany = "${baseUrl}deletecompany";
  static const editcompany = "${baseUrl}editcompany";
  static const addlease = "${baseUrl}addlease";
  static const getlease = "${baseUrl}getlease";

  //inventory
  static const addstore = "${baseUrl}addstore";
  static const getstore = "${baseUrl}getstore";
  static const deletestore = "${baseUrl}deletestore";

  static const addproduct = "${baseUrl}addproduct";
  static const getproduct = "${baseUrl}getproduct";
  static const deleteproduct = "${baseUrl}deleteproduct";
  static const editproduct = "${baseUrl}editproduct";
  static const productin = "${baseUrl}productin";
  static const productout = "${baseUrl}productout";
  static const getLowStock = "${baseUrl}getLowStock";

  static const checkmail = "${baseUrl}checkmailregisterd";
  static const forgetPassword = "${baseUrl}forgetPassword";
  static const restepaswd = "${baseUrl}newpassword";

  // premiume
  static const getpremiume = "${baseUrl}getpremiumpackages";
}
