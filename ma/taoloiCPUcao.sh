#Code tạo lỗi
   yes > /dev/null &
   yes > /dev/null &
   sleep 3
   top -bn1 | head -12
#Code dọn dẹp
pkill yes
top -bn1 | head -12