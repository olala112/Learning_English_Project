from flask import Flask, render_template, request
import pyodbc

app = Flask(__name__)

# Kết nối đến cơ sở dữ liệu
conn = pyodbc.connect('DRIVER={SQL Server};'
                      'SERVER=ACER\MINTUN;'
                      'DATABASE=DB_WEB_ENGLISH')

# Tạo một đối tượng cursor để thực hiện các truy vấn SQL
cursor = conn.cursor()

@app.route('/Vocabulary', methods=['GET', 'POST'])
def home():
    if request.method == 'POST':
        search_word = request.form['search_word']
        
        # Thực hiện truy vấn SQL để lấy thông tin từ cơ sở dữ liệu
        cursor.execute(f"SELECT * FROM Vocabulary WHERE EnglishWord = '{search_word}'")
        result = cursor.fetchone()
        
        if result:
            # Chuyển kết quả từ tuple sang dictionary để dễ sử dụng trong template
            result_dict = {
                'EnglishWord': result.EnglishWord,
                'VietnameseDefinition': result.VietnameseDefinition,
                'PartOfSpeech': result.PartOfSpeech,
                'ExampleSentence': result.ExampleSentence
            }
            return render_template('index3.html', result=result_dict)
        else:
            return render_template('index3.html', message='Word not found!')
    return render_template('index3.html')

if __name__ == '__main__':
    app.run(debug=True)
