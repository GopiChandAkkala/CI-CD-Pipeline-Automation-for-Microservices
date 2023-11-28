FROM python:3.8-slim

WORKDIR /

COPY . /

RUN pip install -r /app/requirements.txt

EXPOSE 5000

ENV NAME World

CMD ["python3","/app/app.py"]
