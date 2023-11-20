from flask import Flask, render_template
import pyodbc

app = Flask(__name__)

# Thông tin kết nối đến cơ sở dữ liệu
conn_str = (
    r'DRIVER={SQL Server};'
    r'SERVER=ACER\MINTUN;'
    r'DATABASE=DB_WEB_ENGLISH;'
    r'Trusted_Connection=yes;'
)

# Hàm thực hiện truy vấn cơ sở dữ liệu
def query_database(query, params=None):
    with pyodbc.connect(conn_str) as conn:
        cursor = conn.cursor()
        if params:
            cursor.execute(query, params)
        else:
            cursor.execute(query)
        result = cursor.fetchall()
    return result

@app.route('/')
def index():
    # Thực hiện truy vấn để lấy dữ liệu từ cơ sở dữ liệu
    query = """
        SELECT 
            Part1.IDPart1,
            QUESTION.LinkQUESTION,
            PICTURE.LinkPicture,
            AUDIO.LinkAudio
        FROM 
            Part1
        JOIN 
            QUESTION ON Part1.IDQUESTION = QUESTION.IDQUESTION
        JOIN 
            PICTURE ON Part1.IDPicture = PICTURE.IDPicture
        JOIN 
            AUDIO ON Part1.IDAudio = AUDIO.IDAudio
        WHERE 
            Part1.IDEXAM = 1 AND Part1.IDQUESTION BETWEEN 110001 AND 110006
    """
    part1_data = query_database(query)

    return render_template('index.html', part1_data=part1_data)

if __name__ == '__main__':
    app.run(debug=True)
