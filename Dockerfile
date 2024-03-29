FROM rust:latest

WORKDIR /app
COPY . /app

ARG DATABASE_URL
ARG PORT
ARG ARCS_FILE
ARG COORDINATES_FILE
ARG SECRET_JWT
ARG FRONTEND_URL


RUN cargo install diesel_cli --no-default-features --features postgres
RUN diesel migration run --database-url $DATABASE_URL

RUN curl https://sebitasc.s3.us-east-2.amazonaws.com/nodes.txt --output nodes.txt
RUN curl https://sebitasc.s3.us-east-2.amazonaws.com/edges.txt --output edges.txt

RUN DATABASE_URL=$DATABASE_URL PORT=$PORT ARCS_FILE=$ARCS_FILE COORDINATES_FILE=$COORDINATES_FILE SECRET_JWT=$SECRET_JWT FRONTEND_URL=$FRONTEND_URL cargo build --release

CMD ["./target/release/tsp"]
