FROM cockroachdb/cockroach:v20.1.4

# install gsutil for copying to gs://
RUN mkdir /dumper
WORKDIR /dumper

RUN apt update

RUN apt install --yes curl
RUN apt install --yes python3-minimal

RUN curl https://sdk.cloud.google.com | bash -s -- --install-dir=/dumper

ENV PATH=/dumper/google-cloud-sdk/bin:/cockroach:$PATH

ADD . .

ENTRYPOINT ["/bin/bash"]

CMD ["/dumper/backup.sh"]
