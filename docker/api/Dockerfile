FROM rust as build-stage

WORKDIR /app

ADD rust-edb-api-axum/ rust-edb-api-axum/
ADD rust-dna/ rust-dna/
ADD rust-genes/ rust-genes/
ADD rust-auth/ rust-auth/
ADD rust-sys/ rust-sys/

WORKDIR /app/rust-edb-api-axum

RUN cargo build --release

# move app into smaller alpine image
FROM debian as release-stage

WORKDIR /

RUN apt update && apt install -y libsqlite3-dev
#RUN apt update && apt install -y openssl-dev
COPY --from=build-stage /app/rust-edb-api-axum/target/release/edb-api-axum /edb-api-axum
# required to open binding to all address and not just localhost
# COPY --from=build-stage /app/rust-edb-api/Rocket.toml /Rocket.toml

EXPOSE 8080

CMD ["/edb-api-axum"]
