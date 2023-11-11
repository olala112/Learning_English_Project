from flask import Flask, render_template, send_file
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)

# Thông tin kết nối SQL Server
server = 'ACER\\MINTUN'  # Điền thông tin máy chủ SQL Server của bạn
database = 'DB_WEB_TEST'  # Điền tên cơ sở dữ liệu của bạn
conn_str = f'mssql+pyodbc://{server}/{database}?driver=SQL+Server'
app.config['SQLALCHEMY_DATABASE_URI'] = conn_str

db = SQLAlchemy(app)

class Audio(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    link = db.Column(db.String(255), nullable=False)

@app.route('/')
def index():
    audios = Audio.query.all()
    return render_template('index.html', audios=audios)

@app.route('/play_audio/<int:audio_id>')
def play_audio(audio_id):
    audio = Audio.query.get(audio_id)
    audio_link = audio.link
    return render_template('play_audio.html', audio_link=audio_link)

if __name__ == '__main__':
    app.run(debug=True)
with app.app_context():
    audio = Audio(link='audio1.mp3')  # Điền tên tệp âm thanh của bạn
    db.session.add(audio)
    db.session.commit()