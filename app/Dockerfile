# Use a base image with the latest version of Rust installed
FROM rust:latest AS builder

# Set the working directory in the container
WORKDIR /app


# Copy the real application code into the container
COPY . .

# Build the application
RUN cargo build  --release

# (Optional) Remove debug symbols
RUN strip target/release/app


# Use a slim image for running the application
FROM alpine:latest AS runtime

ENV PORT=8000
# Copy only the compiled binary from the builder stage to this image
COPY --from=builder /app/target/release/app /bin/app


RUN apk add --no-cache openssl ncurses-libs 
RUN apk add --no-cache openssl ncurses-libs libstdc++
RUN apk add --no-cache libc6-compat bash
RUN chmod +x /bin/app
# Specify the command to run when the container starts
CMD ["app"]
