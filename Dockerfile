FROM rust as build-stage

WORKDIR /app

ADD rust-edb-api/ rust-edb-api/
ADD rust-dna/ rust-dna/
ADD rust-loctogene/ rust-loctogene/

WORKDIR /app/rust-edb-api

RUN ROCKET_ENV=prod cargo build --release

# move app into smaller alpine image
FROM debian as release-stage

WORKDIR /

RUN apt update && apt install -y libsqlite3-dev
COPY --from=build-stage /app/rust-edb-api/target/release/edb-api /edb-api
# required to open binding to all address and not just localhost
COPY --from=build-stage /app/rust-edb-api/src/Rocket.toml /Rocket.toml

EXPOSE 8000

CMD ["/edb-api"]