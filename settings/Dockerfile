 FROM python:3.5.2
 ENV PYTHONUNBUFFERED 1
 ENV PROJECT {name}
 RUN apt-get update
 RUN apt-get install --quiet --assume-yes postgresql-client
 RUN mkdir /code
 WORKDIR /code
 ADD $PROJECT/requirements.txt /code/
 RUN pip install -r requirements.txt
 ADD . /code/
