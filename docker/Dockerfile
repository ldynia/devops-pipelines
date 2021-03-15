FROM python:3.7.9-alpine

ARG PORT=8000
ENV PORT=$PORT

ENV PYTHONUNBUFFERED=True

WORKDIR /app
COPY . /app

RUN apk add \
    gcc \
    libpq \
    musl-dev \
    postgresql-dev
RUN pip install -r /app/requirements.txt --no-cache-dir

# Fixed permissions, create exec:exec and dev:dev
RUN sed -i '/999/d;' /etc/group
RUN addgroup -S -g 999 exec && adduser -u 999 -SDHG exec exec
RUN adduser -DH dev && adduser exec dev
RUN chown -R exec:dev \
    /app \
    /usr/local/bin/ \
    /usr/local/lib/python3.7/
RUN chmod -R a-w /etc

EXPOSE ${PORT}
VOLUME /app

# USER exec:dev

ENTRYPOINT ["/app/scripts/startup.sh"]