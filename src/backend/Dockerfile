# FROM python:3.7
FROM python:3.7-alpine

RUN apk add --no-cache build-base openssl-dev libffi-dev postgresql-dev
RUN adduser -D -g '' sm
RUN addgroup sm sm

# RUN useradd -b /home/sm sm
# RUN usermod -a -G sm sm
# RUN mkdir /home/sm/ && chown -R sm:sm /home/sm

RUN mkdir /home/sm/app && chown -R sm:sm /home/sm/app
USER sm
WORKDIR /home/sm/app

COPY --chown=sm:sm . .
RUN pip3 install --user sm -r requirements.txt

# TODO
EXPOSE 9090
ENTRYPOINT [ "python3" ]
# CMD [ "main.py run" ]
