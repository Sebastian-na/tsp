FROM rust:1.49

WORKDIR /tsp
COPY . .


RUN cargo install diesel_cli --no-default-features --features postgres
RUN cargo build --release


CMD ["./target/release/tsp"]