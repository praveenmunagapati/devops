FROM python:3.12.6
COPY app.py test.py /app/
WORKDIR /app
EXPOSE 5000
RUN pip install flask pytest flake8 # This downloads all the dependencies
CMD ["python", "app.py"]