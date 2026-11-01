# Chi phí đã sử dụng của Khang
Sau khi kiểm tra trên AWS Cost Explorer, Khang ghi nhận tổng chi phí sử dụng các dịch vụ AWS trong tháng 10 là 0,43 USD. Trong đó, dịch vụ EC2-Other phát sinh chi phí cao nhất với 0,30 USD, tiếp theo là Amazon Elastic Compute Cloud - Compute với 0,07 USD, Amazon Virtual Private Cloud với 0,03 USD và Amazon CloudWatch với 0,03 USD.  

# Chi phí đã sử dụng của Khiêm
Kiểm tra AWS Cost Explorer Khiêm đã sử dụng các dịch vụ AWS trong tháng 10 là 0,13 USD. Trong đó, dịch vụ CloudWatch phát sinh chi phí cao nhất là 0,05 USD, tiếp theo là Amazon Elastic Compute Cloud – Compute với 0,02 USD và Amazon Virtual Private Cloud với 0,02 USD và EC2-Instances 0.04 USD  
# Tổng chi phí
Tổng chi phí của Khang và Khiêm trong tháng 10 là 0.56 USD
# Đánh giá và kết luận
Qua số liệu trên, có thể thấy chi phí chủ yếu tập trung vào các tài nguyên liên quan đến EC2, bao gồm chi phí EC2-Other và thời gian sử dụng máy chủ EC2. CloudWatch phát sinh chi phí tương đối thấp do nhóm sử dụng dịch vụ để thu thập Metrics, lưu trữ Logs, thiết lập Alarm và Dashboard phục vụ giám sát hệ thống. Chi phí VPC cũng ở mức thấp trong kỳ thống kê  
Nhìn chung, tổng chi phí vận hành hệ thống trong tháng 10 ở mức thấp, phù hợp với quy mô dự án học tập và thử nghiệm. Nhóm đã tối ưu bằng cách dừng EC2 khi không sử dụng, duy trì thời gian lưu trữ CloudWatch Logs ở mức 7 ngày, sử dụng chu kỳ thu thập Metrics 60 giây và loại bỏ các tài nguyên thử nghiệm không còn cần thiết. Qua đó, nhóm có thể hạn chế chi phí phát sinh và đảm bảo hệ thống giám sát hoạt động hiệu quả, tiết kiệm hơn
