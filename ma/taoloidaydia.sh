#code tạo lỗi
df -h /
sudo fallocate -l 3G /var/bigfile.img
df -h /
#code dọn dẹp
sudo rm -f /var/bigfile.img /var/bigfile2.img
df -h /