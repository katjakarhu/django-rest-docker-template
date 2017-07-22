 FROM python:latest
 ENV PYTHONUNBUFFERED 1
 ENV PROJECT {name}
 RUN apt-get update
 RUN apt-get install --quiet --assume-yes postgresql-client
 RUN apt-get install --quiet --assume-yes python-pip
 RUN pip install virtualenv
 RUN mkdir /code
 WORKDIR /code
 ADD . /code/
 RUN pip install -r $PROJECT/requirements.txt

