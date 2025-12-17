import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/service_locator_dependencies.dart';

extension ResponsiveSize on num {
  double get rpx => sl<SizeConfig>().rpx(toDouble());
  double get isz => sl<SizeConfig>().isz(toDouble());
  double get sp => sl<SizeConfig>().sp(toDouble());
  double get gap => sl<SizeConfig>().gap(toDouble());
}
