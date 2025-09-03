cấp quyền cho user 
GRANT CREATE, ALTER, DROP, INDEX, SELECT, INSERT, UPDATE, DELETE ON *.* TO 'vodaplayuser'@'%';
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON vodaplaydb.* TO 'vodaplayuser'@'%';
FLUSH PRIVILEGES;


2️⃣ Cấu trúc prompt gợi ý cho video ~10s

[Thời lượng] + [Chủ đề] + [Hình ảnh/Animation style] + [Background/Environment] + [Chi tiết hành động] + [Âm thanh/nhạc nền] + [Camera/Lighting]

Ví dụ:
"A 10-second animated video of a golden retriever puppy playing in a sunny garden, cartoon 3D style, soft shadows, cheerful background music, camera pans from left to right"

flow dự án 

Client ---gửi request---> API Server ---push task---> RabbitMQ Queue
Worker ---lấy task---> tạo video
         └─> cập nhật progress vào Redis (key=task_id)
Client ---poll hoặc WebSocket---> đọc progress từ Redis
