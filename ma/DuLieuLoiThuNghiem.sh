
LG=/my-log-group

for i in 1 2 3; do
  cat > ev.json <<EOF
[{"timestamp": $(date +%s000), "message": "{\"status\":\"INFO\",\"message\":\"Sample log entry $i\"}"}]
EOF

  aws logs put-log-events \
    --log-group-name "$LG" \
    --log-stream-name my-log-stream \
    --log-events file://ev.json

  sleep 2
done
