FROM rust:latest

WORKDIR /tsp
COPY . .


RUN cargo install diesel_cli --no-default-features --features postgres
RUN diesel migration run
RUN cargo build --release


CMD ["./target/release/tsp"]