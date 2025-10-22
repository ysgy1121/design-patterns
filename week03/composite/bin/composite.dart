import 'package:composite/company.dart';
import 'package:composite/department.dart';
import 'package:composite/employee.dart';

void main(List<String> arguments) {
  var company = Company('A기업');
  company.add(Employee('김사장', 'CEO'));

  var hr = Department('인사');
  hr.add(Employee('이인사', '인사 매니저'));
  hr.add(Employee('김인사', '인사 스페셜리스트'));
  company.add(hr);

  var finance = Department('재무');
  finance.add(Employee('이재무', '재무 매니저'));
  finance.add(Employee('김재무', '재무 스페셜리스트'));
  company.add(finance);

  var marketing = Department('마케팅');
  marketing.add(Employee('이마케팅', '마케팅 매니저'));
  marketing.add(Employee('김마케팅', '마케팅 스페셜리스트'));
  company.add(marketing);

  var sales = Department('영업');
  sales.add(Employee('이영업', '영업 매니저'));
  sales.add(Employee('김영업', '영업 스페셜리스트'));
  company.add(sales);

  var engineering = Department('개발');
  engineering.add(Employee('이개발', '개발 매니저'));
  engineering.add(Employee('김개발', '개발 스페셜리스트'));
  company.add(engineering);

  company.display();
}
