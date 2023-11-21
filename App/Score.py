from flask import Flask, render_template, redirect, url_for, request
import pyodbc 
app = Flask(__name__)
#Kết nối với DataBases SQL Server
conn = pyodbc.connect('DRIVER={SQL Server};SERVER=LAPTOP-1JG6K1EH\ENDTIDI_001;DATABASE=DB_WEB_ENGLISH;')

cursor = conn.cursor()

@app.route('/', methods = ['GET' , 'POST'])
def index():
    if request.method == 'POST':
        redirect(url_for('Score'))
    else:
        return render_template('Button_Score.html')


@app.route('/Score')
def Score():
    #Truy vấn điểm từ DataBases
        cursor.execute("SELECT User1.IDUser, User1.TotalScore, QL_EXAM.PointExam FROM User1 INNER JOIN QL_EXAM ON User1.IDUser = QL_EXAM.IDUser WHERE User1.IDUser = 10")
        Score = cursor.fetchone()
        #PointExams = cursor.fetchone()
        return render_template('Score.html',  IDUser = Score[0], TotalScore = Score[1], PointExam = Score[2])


if __name__ == '__main__':
    app.run(debug=True)
