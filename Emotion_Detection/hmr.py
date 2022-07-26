import random

from flask import Flask
from flask import request

import Emotion_Recognizer

app = Flask(__name__)

path = "C:\\Users\\ASUS\\Desktop\\Runtime_Terrors-main\\Runtime_Terrors-main\\FILES"


def get_random_id():
    a = ""

    for i in range(0, 10):
        a += chr(random.randint(65, 90))

    print(a)

    return a


def detect_emotion(uid, file):
    """
    This method should return
            -> "Happy",
            -> "Sad",
            -> "Neutral"
        by using file.
    """

    name = path + uid + ".png"
    file.save(name)

    emo = Emotion_Recognizer.Emotion.read(uid, name)
    return emo.capitalize()


def send_emotion(uid, emotion):
    # moodes = ["Happy", "Sad", "Neutral"]

    # Emotion is "Happy", "Sad", "Neutral"
    # Do anything with emotion

    print(f"Emotion received from: {uid} | Emotion: {emotion}")

    pass


@app.route('/emotion', methods=['POST'])
def emotion():
    uid = request.args.get("id")
    data = request.files["Image"]

    return detect_emotion(uid, data)


@app.route('/emotion', methods=['GET'])
def real_emotion():
    uid = request.args.get("id")
    e = request.args.get("emotion")
    send_emotion(uid, e)

    return e


@app.route('/id', methods=['GET'])
def get_id():
    return get_random_id()


def main():
    app.run(host='192.168.1.100', port=8086)


if __name__ == '__main__':
    main()
