from flask import Flask, render_template, request
import pyodbc

app = Flask(__name__)

# Kết nối đến cơ sở dữ liệu SQL Server
conn = pyodbc.connect('DRIVER={SQL Server};'
                      'SERVER=ACER\MINTUN;'
                      'DATABASE=DB_WEB_TEST;'
                      )


cursor = conn.cursor()

@app.route('/')
def index():
    # Truy vấn danh sách các audio từ cơ sở dữ liệu
    cursor.execute('SELECT IDAudio, LinkAudio FROM dbo.Audio')
    audio_files = cursor.fetchall()
    return render_template('index.html', audio_files=audio_files)

@app.route('/play/<int:audio_id>')
def play_audio(audio_id):
    # Truy vấn đường dẫn đến file âm thanh từ cơ sở dữ liệu
    cursor.execute('SELECT LinkAudio FROM dbo.Audio WHERE IDAudio=?', (audio_id,))
    link_audio = cursor.fetchone()[0]
    return send_file(link_audio, as_attachment=True)

if __name__ == '__main__':
    app.run(debug=True)
