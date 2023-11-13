FROM tiangolo/uwsgi-nginx-flask:python3.11

WORKDIR /app

COPY nate_site nate_site
COPY requirements.txt requirements.txt
COPY wsgi.py wsgi.py
COPY uwsgi.ini uwsgi.ini

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV STATIC_PATH /app/nate_site/static

RUN pip install --upgrade pip
RUN pip install -r /app/requirements.txt

