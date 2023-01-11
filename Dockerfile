FROM rust:latest

WORKDIR /app
COPY . /app


RUN cargo install diesel_cli --no-default-features --features postgres
RUN ls
RUN diesel migration run
RUN cargo build --release


CMD ["./target/release/tsp"]