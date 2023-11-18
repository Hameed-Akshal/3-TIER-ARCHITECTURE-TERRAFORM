#!/bin/bash -xe

sudo su
mkdir demoapp
cd demoapp

yum install -y python3

yum install -y python3-pip

echo "
from flask import Flask

app = Flask(__name__)


@app.route('/')
def home():
    return 'Hello,This is the Hameed Akshal'


@app.route('/rifath')
def custom():
    return 'Hello,This is Rifath.'


@app.route('/fahim')
def greet():
    return 'Hello, This is Fahim.'


if __name__ == '__main__':
    app.run(host='0.0.0.0',port=80)

" >> app.py

yum update -y

pip3 install flask

python3 app.py
