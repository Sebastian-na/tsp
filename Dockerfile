FROM rust:latest

WORKDIR /app
COPY . /app

ARG DATABASE_URL

RUN cargo install diesel_cli --no-default-features --features postgres
RUN diesel migration run --database-url $DATABASE_URL

RUN curl https://sebitasc.s3.us-east-2.amazonaws.com/nodes.txt --output nodes.txt
RUN curl https://sebitasc.s3.us-east-2.amazonaws.com/edges.txt --output edges.txt

RUN cargo build --release


CMD ["./target/debug/tsp"]
