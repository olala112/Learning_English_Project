from flask import Flask, render_template, request, redirect
import pyodbc

app = Flask(__name__)

# Thông tin kết nối SQL Server
server = 'ACER\MINTUN'
database = 'DB_WEB_TEST'
conn_str = f'DRIVER={{SQL Server}};SERVER={server};DATABASE={database}'

from flask import Flask, render_template, request, redirect

app = Flask(__name__)

# Kết nối đến cơ sở dữ liệu SQL Server
conn = pyodbc.connect('DRIVER={SQL Server};'
                      'SERVER=ACER\MINTUN;'
                      'DATABASE=DB_WEB_TEST;'
                    )

cursor = conn.cursor()

@app.route('/')
def index():
    # Truy vấn câu hỏi từ cơ sở dữ liệu
    cursor.execute('SELECT * FROM dbo.QUESTION')
    questions = cursor.fetchall()
    return render_template('index.html', questions=questions)

@app.route('/submit', methods=['POST'])
def submit():
    score = 0
    for question_id, answer in request.form.items():
        # Lấy đáp án đúng từ cơ sở dữ liệu
        cursor.execute('SELECT DAPAN FROM your_table WHERE ID=?', (question_id,))
        correct_answer = cursor.fetchone()[0]

        # So sánh với đáp án người dùng
        if answer == correct_answer:
            score += 1

    return f'Score: {score}'

if __name__ == '__main__':
    app.run(debug=True)

