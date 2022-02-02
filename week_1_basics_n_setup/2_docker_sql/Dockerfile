FROM python:3.9
# base image

RUN apt-get install wget
RUN pip install pandas sqlalchemy psycopg2
# install packages in the container to create a new image based on these installation

WORKDIR /app
# create and cd into the app directory

COPY ingest_data.py ingest_data.py
# copy file from source (host) to destination (image)

ENTRYPOINT [ "python", "ingest_data.py" ]
# override python prompt to run ingest_data.py