# Nguyễn Tuấn Khang - 24110025  
Số giờ: 8 giờ  
Kiểm tra VPC, subnet, Internet Gateway, route table đã tạo ở tuần 1  
Link: [code](https://github.com/CainDealer/Monitoring-with-CloudWatch/blob/main/ma/kiemtravpc.sh)  
Tạo EC2 chạy ứng dụng web thử nghiệm, kiểm tra truy cập và trạng thái hoạt động  
Link: [ảnh trong AWS](https://github.com/CainDealer/Monitoring-with-CloudWatch/blob/main/tailieu/anhminhchung/ec2trongaws.png)  
[ảnh trang web nginx](https://github.com/CainDealer/Monitoring-with-CloudWatch/blob/main/tailieu/anhminhchung/webtestec2.png)  
Cài đặt CloudWatch Agent trên EC2 và cấu hình Agent thu thập các chỉ số bổ sung như RAM, dung lượng đĩa và mức sử dụng đĩa  
Link: [code](https://github.com/CainDealer/Monitoring-with-CloudWatch/blob/main/ma/taoagent.sh)  
[ảnh trong AWS](https://github.com/CainDealer/Monitoring-with-CloudWatch/blob/main/tailieu/anhminhchung/taoagent.png)  
Lưu cấu hình Agent trong Systems Manager Parameter Store  
Link: [code](https://github.com/CainDealer/Monitoring-with-CloudWatch/blob/main/ma/luuagenttrongparameterstore.sh)  
[ảnh trong AWS](https://github.com/CainDealer/Monitoring-with-CloudWatch/blob/main/tailieu/anhminhchung/agenttrongparamaterstore.png)  
Khởi động Agent, kiểm tra dữ liệu được gửi lên CloudWatch  
Link: [ảnh trong AWS](https://github.com/CainDealer/Monitoring-with-CloudWatch/blob/main/tailieu/anhminhchung/metriccuaagent.png)  

# Đào Gia Khiêm - 24110026  
Số giờ: 8 giờ  
Tạo CloudWatch Log Group để nhận log ứng dụng web hoặc web server từ EC2  
Thiết lập thời gian lưu log (retention 7 ngày)  
Link: [Log group có Retention = 1 week](https://github.com/CainDealer/Monitoring-with-CloudWatch/blob/main/tailieu/anhminhchung/LoggroupcoRetention7days.png)  
Tạo Metric Filter để đếm lỗi HTTP 5xx trong log  
Link: [Metric filter](https://github.com/CainDealer/Monitoring-with-CloudWatch/blob/main/tailieu/anhminhchung/Metric%20filter.png)  
Tạo SNS Topic và đăng ký email nhận cảnh báo, xác nhận đăng ký email  
Link: [SNS subscription Confirmed](https://github.com/CainDealer/Monitoring-with-CloudWatch/blob/main/tailieu/anhminhchung/SNSsubscriptionstatusConfirmed.png)  
Tạo thử một CloudWatch Alarm dựa trên metric lỗi 5xx và cấu hình gửi thông báo qua SNS  
Link: [Alarm In alarm](https://github.com/CainDealer/Monitoring-with-CloudWatch/blob/main/tailieu/anhminhchung/AlarmInalarm.png) [Email cảnh báo](https://github.com/CainDealer/Monitoring-with-CloudWatch/blob/main/tailieu/anhminhchung/Emailcanhbao.png)  
Tạo dữ liệu lỗi thử nghiệm để kiểm tra Metric Filter và Alarm   
Link: [Dữ liệu lõi thử nghiệm](https://github.com/CainDealer/Monitoring-with-CloudWatch/blob/main/ma/DuLieuLoiThuNghiem.sh)  

# Kế hoạch tuần 3

