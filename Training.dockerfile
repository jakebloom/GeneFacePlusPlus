FROM pytorch/pytorch:2.2.2-cuda11.8-cudnn8-runtime

COPY . .

RUN apt update
RUN apt-get -y install git
RUN apt-get -y install gcc
RUN apt-get -y install g++
RUN sh setup.sh

CMD ["sh", "train.sh"]
