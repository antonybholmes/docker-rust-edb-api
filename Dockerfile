FROM rust as build-stage

WORKDIR /app

ADD rust-edb-api/ rust-edb-api/
ADD rust-dna/ rust-dna/
ADD rust-loctogene/ rust-loctogene/

WORKDIR /app/rust-edb-api

RUN cargo build --release

# move app into smaller alpine image
FROM debian as release-stage

WORKDIR /

RUN apt update && apt install -y libsqlite3-dev
COPY --from=build-stage /app/rust-edb-api/target/release/edb-api /edb-api

EXPOSE 8000

CMD ["/edb-api"]