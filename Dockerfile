FROM cockroachdb/cockroach:v20.1.4

# install gsutil for copying to gs://
RUN mkdir /dumper
WORKDIR /dumper

RUN apt-get update

RUN apt-get install --yes curl
RUN apt-get install --yes gcc python3-dev python3-setuptools python3-pip
RUN pip3 install --no-cache-dir -U crcmod

RUN curl https://sdk.cloud.google.com | bash -s -- --install-dir=/dumper

ENV PATH=/dumper/google-cloud-sdk/bin:/cockroach:$PATH

ADD . .

ENTRYPOINT ["/bin/bash"]

CMD ["/dumper/backup.sh"]
