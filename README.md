# Monitoring-with-CloudWatch
Thiết lập hệ thống giám sát cho ứng dụng web, thu thập metric tùy chỉnh và log bằng CloudWatch Agent, cảnh báo và dashboard.  
Hệ thống sử dụng CloudWatch Agent để thu thập các chỉ số CPU, RAM, Disk và nhật ký hoạt động của Nginx. Các dữ liệu được gửi về CloudWatch để theo dõi, phân tích và cảnh báo khi phát hiện lỗi.
# Thông tin
Môn học Điện toán đám mây
GVHD: TS Huỳnh Xuân Phụng  
Sinh viên thực hiện:  
Nguyễn Tuấn Khang - 24110025 - CainDealer  
Đào Gia Khiêm - 24110026 - Chinossssssssssssssssssssssssssssssssss  
# Báo cáo tuần 1  
[Link](https://github.com/CainDealer/Monitoring-with-CloudWatch/blob/main/tailieu/phancongtuan1.md)  

# Báo cáo tuần 2
[Link](https://github.com/CainDealer/Monitoring-with-CloudWatch/blob/main/tailieu/phancongtuan2.md)  

# Báo cáo tuần 3
[Link](https://github.com/CainDealer/Monitoring-with-CloudWatch/blob/main/tailieu/phancongtuan3.md)  
# Báo cáo tuần 4
[Link](https://github.com/CainDealer/Monitoring-with-CloudWatch/blob/main/tailieu/phancongtuan4.md)

# Yêu cầu trước khi triển khai 
Tài khoản AWS hoặc AWS Academy Learner Lab  
AWS Region sử dụng: us-east-1  
Quyền tạo và quản lý EC2, VPC, IAM, CloudWatch và SNS  
# Tài nguyên cần chuẩn bị
VPC với CIDR `10.0.0.0/16`  
EC2 Instance sử dụng Amazon Linux  
IAM Role cho EC2 có quyền gửi dữ liệu lên CloudWatch  
Security Group cho phép HTTP theo nhu cầu triển khai  
# Hướng dẫn triển khai
Tạo VPC với CIDR `10.0.0.0/16`,gắn các Tag quản lý tài nguyên  
Tạo EC2 sử dụng Amazon Linux với VPC và Subnet đã tạo. Ngoài ra cấu hình Security group theo nhu cầu  
Sau đó kết nối EC2 và cài đặt Nginx:  
```bash
sudo dnf update -y
sudo dnf install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx
```  
Kiểm tra trạng thái:  
```bash
sudo systemctl status nginx
```  
Truy cập địa chỉ Public IPv4 của EC2 bằng trình duyệt dưới dạng http để kiểm tra website   
Cài đặt Agent trên Amazon Linux:  
```bash
sudo dnf install amazon-cloudwatch-agent -y
```  
Tạo file cấu hình:  
```bash
sudo nano /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
```  
Nội dung cấu hình mẫu:  
```json
{
  "agent": {
    "metrics_collection_interval": 60,
    "run_as_user": "root"
  },
  "metrics": {
    "namespace": "CWAgent",
    "append_dimensions": {
      "InstanceId": "${aws:InstanceId}"
    },
    "metrics_collected": {
      "mem": {
        "measurement": [
          "mem_used_percent"
        ],
        "metrics_collection_interval": 60
      },
      "disk": {
        "measurement": [
          "used_percent"
        ],
        "resources": [
          "/"
        ],
        "metrics_collection_interval": 60
      }
    }
  },
  "logs": {
    "logs_collected": {
      "files": {
        "collect_list": [
          {
            "file_path": "/var/log/nginx/access.log",
            "log_group_name": "/aws/ec2/cloudwatch-monitoring/nginx/access",
            "log_stream_name": "{instance_id}"
          },
          {
            "file_path": "/var/log/nginx/error.log",
            "log_group_name": "/aws/ec2/cloudwatch-monitoring/nginx/error",
            "log_stream_name": "{instance_id}"
          }
        ]
      }
    }
  }
}
```  
Lưu file cấu hình và khởi động Agent:  
```bash
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
  -a fetch-config \
  -m ec2 \
  -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json \
  -s
```  
Sử dụng AWS CLI để lưu cấu hình Agent:  
```bash
aws ssm put-parameter \
  --name "AmazonCloudWatch-Linux-EC2-Config" \
  --type "String" \
  --value file:///opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json \
  --region us-east-1
```  
Sau đó vào Parameter Store để kiểm tra  
Truy cập Log Management trong CloudWatch để kiểm tra hai Log Groups:  
`/aws/ec2/cloudwatch-monitoring/nginx/access`  
`/aws/ec2/cloudwatch-monitoring/nginx/error`  
Thiết lập thời gian lưu trữ Logs là 7 ngày  
Tại Log Group Access, tạo Metric Filter với Filter pattern `[ip, identity, user, timestamp, request, status_code=5*, size]` và Metric Value 1  
Truy cập Amazon SNS -> Topics để tạo Subscription với Protocol là Email và xác nhận đăng ký email  
Tạo CloudWatch Alarm với:
- Statistic: Sum  
- Period: 1 minute  
- Threshold: Greater than or equal to 5  
- Evaluation period: 1 of 1  
- Notification: SNS Topic đã tạo  

Truy cập CloudWatch -> Dashboards để tạo dashboard sau đó thêm các widget CPUUtilization, mem_used_percent, HTTP5xxCount, disk_used_percent để theo dõi  
Cuối cùng tạo endpoint để kiểm thử HTTP 500 trong môi trường thử nghiệm bằng cấu hình Nginx:  
```conf
server {
    listen 8080;
    server_name _;
    access_log /var/log/nginx/access.log;

    location = /test-500 {
        return 500;
    }
}
```  
Kiểm tra cấu hình và tải lại Nginx:  
```bash
sudo nginx -t
sudo systemctl reload nginx
```  
Tạo 5 yêu cầu kiểm thử:  
```bash
for i in {1..5}; do
  curl -s -o /dev/null -w "%{http_code}\n" \
  http://localhost:8080/test-500
done
```  
Sau đó đợi 1-3 phút và kiểm tra access Log trên CloudWatch, metric HTTP5xxCount, trạng thái CloudWatch Alarm, email thông báo từ SNS.



