from flask import Flask, send_file, render_template
import pyodbc

# Kết nối đến cơ sở dữ liệu
conn = pyodbc.connect('DRIVER={SQL Server};'
                      'SERVER=ACER\MINTUN;'
                      'DATABASE=DB_WEB_ENGLISH')

# Tạo đối tượng cursor để thao tác với cơ sở dữ liệu
cursor1 = conn.cursor()

# Thực hiện truy vấn
cursor1.execute("SELECT LinkAudio FROM AUDIO WHERE IDAudio = ?")

# Lấy kết quả
result1 = cursor1.fetchone()

# Đóng kết nối
conn.close()

# Kiểm tra và sử dụng đường dẫn file
if result1:
    file_path = result1[0]
    print(f"Đường dẫn của file.mp3: {file_path}")
    # Tiếp theo, bạn có thể sử dụng đường dẫn này để phát file.mp3 trên web.
else:
    print("Không tìm thấy file.mp3")


app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index2.html')

@app.route('/play_audio')
def play_audio():
    return send_file(file_path, mimetype='audio/mp3')
if __name__ == '__main__':
    app.run(debug=True)
