FROM rust as build-stage

WORKDIR /app

ADD rust-edb-api/ rust-edb-api/
ADD rust-dna/ rust-dna/
ADD rust-genes/ rust-genes/
ADD rust-auth/ rust-auth/
ADD rust-sys/ rust-sys/

WORKDIR /app/rust-edb-api

RUN ROCKET_ENV=prod cargo build --release

# move app into smaller alpine image
FROM debian as release-stage

WORKDIR /

RUN apt update && apt install -y libsqlite3-dev
RUN apt update && apt install -y openssl-dev
COPY --from=build-stage /app/rust-edb-api/target/release/edb-api /edb-api
# required to open binding to all address and not just localhost
COPY --from=build-stage /app/rust-edb-api/Rocket.toml /Rocket.toml

EXPOSE 8080

CMD ["/edb-api"]