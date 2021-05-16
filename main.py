from flask import Flask,render_template,request,session,redirect,flash
from flask_sqlalchemy import SQLAlchemy
from flask_mail import Mail
from datetime import datetime
from werkzeug.utils import secure_filename
import json
import os
import math

with open("config.json","r") as c:
    params = json.load(c)["params"]

local_server = True

app = Flask(__name__)
app.secret_key = "super-secret-key"
app.config['UPLOAD_FOLDER'] = params['upload_location']

app.config.update(
    MAIL_SERVER = 'smtp.gmail.com',
    MAIL_PORT = '465',
    MAIL_USE_SSL = True,
    MAIL_USERNAME = params['gmail_user'],
    MAIL_PASSWORD = params['gmail_password']
)
mail = Mail(app)

if (local_server):
    app.config['SQLALCHEMY_DATABASE_URI'] = params['local_uri']
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['production_uri']

db = SQLAlchemy(app)

class Contacts(db.Model):
    '''
    sno,name ,email,phone_num,message,date
    '''
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), nullable=False)
    email = db.Column(db.String(20), nullable=False)
    phone_num = db.Column(db.String(12), nullable=False)
    message = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(12),nullable=True)

class posts(db.Model):
    '''
    sno,title,slug,content,date
    '''
    sno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80), nullable=False)
    tagline = db.Column(db.String(25), nullable=False)
    slug = db.Column(db.String(25), nullable=False)
    content = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(12),nullable=True)
    img_file = db.Column(db.String(12), nullable=True)


@app.route('/')
def home():
    post = posts.query.filter_by().all()
    last = math.ceil(len(post)/int(params['no_of_posts']))
    # [0: params['no_of_posts']]
    page = request.args.get('page')
    if (not str(page).isnumeric()):
         page = 1
    page = int(page)
    post = post[(page-1)*int(params['no_of_posts']): (page-1)*int(params['no_of_posts'])+ int(params['no_of_posts'])]
    # pagination logic
    # first
    if (page == 1):
        prev = "#"
        next = "/?page=" + str(page + 1)
    elif (page == last):
        prev = "/?page=" + str(page - 1)
        next = "#"
    else:
        prev = "/?page=" + str(page - 1)
        next = "/?page=" + str(page + 1)

    return render_template('index.html',params=params,post=post,prev=prev,next=next)


@app.route('/about')
def about():
    return render_template('about.html',params=params)

@app.route('/dashboard',methods=['GET','POST'])
def dashboard():
    if ('user' in session and session['user'] == params['admin_user']):
        post = posts.query.all()
        return render_template('dashboard.html',params=params,post=post)

    if request.method=='POST':
      '''REDIRECT TO ADMIN PANEEL'''
      username = request.form.get('uname')
      userpass = request.form.get('pass')
      if(username == params['admin_user'] and userpass == params['admin_password']):
        #set the session varialbe
        session['user'] = username
        post = posts.query.all()
        return render_template('dashboard.html',params=params,post=post)

    return render_template('login.html',params=params)

@app.route("/post/<string:post_slug>",methods = ['GET'])
def post_route(post_slug):

    post = posts.query.filter_by(slug = post_slug).first()
    return render_template('post.html',params=params,post = post)

@app.route("/edit/<string:sno>",methods= ['GET','POST'])
def edit(sno):
    if ('user' in session and session['user'] == params['admin_user']):
        if request.method == 'POST':
            box_title = request.form.get('title')
            tagline = request.form.get('tagline')
            slug = request.form.get('slug')
            content = request.form.get('content')
            img_file = request.form.get('img_file')
            date = datetime.now()
            if sno == '0':
                post = posts(title=box_title,tagline=tagline,slug=slug,content=content,img_file=img_file,date=date)
                db.session.add(post)
                db.session.commit()
            else:
                post = posts.query.filter_by(sno=sno).first()
                post.title = box_title
                post.slug = slug
                post.content = content
                post.tagline = tagline
                post.img_file = img_file
                post.date = date
                db.session.commit()
                return redirect('/edit/' + sno)
        post = posts.query.filter_by(sno=sno).first()
        return render_template('edit.html',params=params,post=post,sno=sno)


@app.route('/uploader',methods= ['GET','POST'])
def uploader():
    if ('user' in session and session['user'] == params['admin_user']):
       if (request.method == 'POST'):
           f = request.files['file1']
           f.save(os.path.join(app.config['UPLOAD_FOLDER'],secure_filename(f.filename) ))
           return "Uploaded Succesfully"

@app.route('/logout')
def logout():
    session.pop('user')
    return redirect('/dashboard')

@app.route("/delete/<string:sno>",methods= ['GET','POST'])
def delete(sno):
    if ('user' in session and session['user'] == params['admin_user']):
        post = posts.query.filter_by(sno=sno).first()
        db.session.delete(post)
        db.session.commit()
    return redirect('/dashboard')



@app.route('/contact',methods= ['GET','POST'])
def contact():
    if (request.method=='POST'):
        '''Add entry to the database'''
        name = request.form.get('name')
        email = request.form.get('email')
        phone = request.form.get('phone')
        message = request.form.get('message')
        entry = Contacts(name=name,phone_num=phone,message=message,date=datetime.now(),email=email)
        db.session.add(entry)
        db.session.commit()
        mail.send_message('New Message From ' + name,
                          sender = email,
                          recipients = [params['gmail_user']],
                          body = message + "\n" + phone
                          )
        flash("Thanks for submitting your details. We will get back to you soon","success")
    return render_template('contact.html',params=params)

if __name__ == "__main__":
    app.run(host="0.0.0.0",port=5000)


