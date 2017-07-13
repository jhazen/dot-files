#!/usr/bin/env python
from flask import Flask, request, render_template
import logging
app = Flask(__name__)

@app.route("/ping")
def ping():
    return "pong"

@app.route("/dash")
def dash_player_landing():
    return render_template('dash-landing.html')

@app.route("/dash", methods=['POST'])
def dash_player():
    vhtml = render_template('dash-player.html', vurl=request.form['url'])
    return vhtml





if __name__ == "__main__":
    logging.basicConfig(filename='server.log', level=logging.INFO)
    app.run(host='0.0.0.0', port=8080)
