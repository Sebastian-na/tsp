FROM rust:latest

WORKDIR /app
COPY . /app

ARG DATABASE_URL


RUN cargo install diesel_cli --no-default-features --features postgres
RUN diesel migration run --database-url $DATABASE_URL
RUN cargo build --release


CMD ["./target/release/tsp"]
