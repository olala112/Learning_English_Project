from flask import Flask, render_template, redirect, url_for, request
import pyodbc 
app = Flask(__name__)
#Kết nối với DataBases SQL Server
conn = pyodbc.connect('DRIVER={SQL Server};SERVER=LAPTOP-1JG6K1EH\ENDTIDI_001;DATABASE=DB_WEB_ENGLISH;')

cursor = conn.cursor()


@app.route('/', methods = ['GET' , 'POST'])
def index():
    if request.method == 'POST':
        redirect(url_for('User'))
    else:
        return render_template('Button_User.html')


@app.route('/User')
def User():
    #Truy vấn điểm từ DataBases
        cursor.execute("SELECT IDUser, Name, SEX, Achievement FROM User1 WHERE IDUser = 10")
        User = cursor.fetchone()
        #PointExams = cursor.fetchone()
        return render_template('User.html',  IDUser = User[0], Name = User[1], SEX = User[2], Achievement = User[3])


if __name__ == '__main__':
    app.run(debug=True)
