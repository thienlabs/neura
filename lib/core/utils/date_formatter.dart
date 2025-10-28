import 'package:intl/intl.dart';

class DateFormatter {
  static String formatLastMessageTime(String isoString) {
    // 1. Parse chuỗi ISO 8601. Dart tự động hiểu định dạng 'Z' (UTC).
    if (isoString.isEmpty) {
      return '';
    }
    final messageDateTime = DateTime.parse(isoString).toLocal();

    // 2. Lấy thời gian hiện tại ở múi giờ địa phương
    final now = DateTime.now();

    // 3. Tạo các đối tượng DateTime chỉ chứa ngày (loại bỏ giờ, phút, giây) để so sánh
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final messageDate = DateTime(messageDateTime.year, messageDateTime.month, messageDateTime.day);

    // 4. So sánh và định dạng
    if (messageDate == today) {
      // Nếu là hôm nay -> định dạng giờ:phút (ví dụ: "1:40 CH")
      return DateFormat('h:mm a').format(messageDateTime);
    } else if (messageDate == yesterday) {
      // Nếu là hôm qua -> "Hôm qua"
      return 'Yesterday';
    } else {
      // Nếu cũ hơn -> định dạng ngày/tháng/năm (ví dụ: "28/10/2025")
      return DateFormat('dd/MM/yyyy').format(messageDateTime);
    }
  }
}