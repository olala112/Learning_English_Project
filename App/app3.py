from flask import Flask, render_template, request, redirect,send_file
import pyodbc

app = Flask(__name__)

# Kết nối đến cơ sở dữ liệu SQL Server
conn = pyodbc.connect('DRIVER={SQL Server};'
                      'SERVER=ACER\MINTUN;'
                      'DATABASE=DB_WEB_ENGLISH')

cursor = conn.cursor()
# Tạo đối tượng cursor để thao tác với cơ sở dữ liệu
cursor1 = conn.cursor()

# Thực hiện truy vấn
cursor1.execute("SELECT LinkAudio FROM AUDIO WHERE IDAudio = 100000")

# Lấy kết quả
result1 = cursor1.fetchone()


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
    # Truy vấn câu hỏi từ cơ sở dữ liệu
    cursor.execute('SELECT * FROM QUESTION WHERE IDQUESTION>=1101')
    questions = cursor.fetchall()
    return render_template('Question.html', questions=questions)
@app.route('/play_audio')
def play_audio():
    return send_file(file_path, mimetype='audio/mp3')

@app.route('/submit', methods=['POST'])
def submit():
    score = 0
    for question_id, answer in request.form.items():
        # Lấy đáp án đúng từ cơ sở dữ liệu
        cursor.execute('SELECT ANSWER FROM QUESTION WHERE IDQUESTION=?', (question_id,))
        correct_answer = cursor.fetchone()[0]

        # So sánh với đáp án người dùng
        if answer == correct_answer:
            score += 1

    return f'Score: {score}'

if __name__ == '__main__':
    app.run(debug=True)
