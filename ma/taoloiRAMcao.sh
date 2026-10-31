#code tạo lỗi cấp phát 400mb RAM trong 10p
python3 -c "x='a'*(400*1024*1024); import time; time.sleep(600)" &
sleep 5
free -m
#code dọn dẹp
pkill python3
free -m