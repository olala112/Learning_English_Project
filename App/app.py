from flask import Flask, render_template
import pyodbc

app = Flask(__name__)

# Thông tin kết nối SQL Server
server = 'ACER\MINTUN'
database = 'DB_WEB_TEST'
conn_str = f'DRIVER={{SQL Server}};SERVER={server};DATABASE={database}'

@app.route('/')
def index():
    try:
        connection = pyodbc.connect(conn_str)
        cursor = connection.cursor()

        # Thực hiện truy vấn SQL
        cursor.execute('SELECT * FROM dbo.User1')

        # Lấy kết quả
        rows = cursor.fetchall()

        return render_template('index.html', rows=rows)
    except Exception as e:
        return f"Lỗi khi kết nối that: {e}"

if __name__ == '__main__':
    app.run(debug=True)
