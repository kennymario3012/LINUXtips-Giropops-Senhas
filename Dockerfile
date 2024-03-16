# Stage 1: Build Flask application with ChainGuard image
FROM cgr.dev/chainguard/python:latest-dev as building

LABEL maintainer="kennymarioantonio@gmail.com" \
      day="03"
      
WORKDIR /app

COPY requirements.txt .

#Copy app files
COPY ./static/ /app/static
COPY ./templates/ /app/templates
COPY ./tailwind.config.js .
COPY app.py .

# Install Flask dependencies
RUN pip install -r requirements.txt --user

# Stage 2: Final image Flask application
FROM cgr.dev/chainguard/python:latest

ENV REDIS_HOST redis-server

WORKDIR /app

COPY --from=building /home/nonroot/.local/lib/python3.12/site-packages /home/nonroot/.local/lib/python3.12/site-packages
COPY --from=building /home/nonroot/.local/bin  /home/nonroot/.local/bin

COPY --from=building /app/ .

ENV PATH=$PATH:/home/nonroot/.local/bin

ENTRYPOINT ["flask"]

CMD [ "run","--host=0.0.0.0" ]