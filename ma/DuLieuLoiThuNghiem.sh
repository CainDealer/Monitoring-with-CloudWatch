Tạo 3 log lỗi 500:
LG=/webapp/access
for i in 1 2 3; do
cat > ev.json <<EOF
[{"timestamp": $(date +%s000), "message": "{\"status\":500,\"path\":\"/api/test\"}"}]
EOF
aws logs put-log-events --log-group-name $LG --log-stream-name test-stream --log-events file://ev.json
sleep 2
done
Tạo 1 log thành công (200) để chứng minh filter không đếm nhầm:
cat > ev.json <<EOF
[{"timestamp": $(date +%s000), "message": "{\"status\":200,\"path\":\"/\"}"}]
EOF
aws logs put-log-events --log-group-name $LG --log-stream-name test-stream --log-events file://ev.json