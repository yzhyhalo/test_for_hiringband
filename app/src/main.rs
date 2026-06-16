use axum::{routing::get, Router};
use std::net::SocketAddr;
use tokio::net::TcpListener;

async fn hello_world() -> &'static str {
    "Hello world!"
}

#[tokio::main]
async fn main() {
    let router = Router::new().route("/", get(hello_world));

    let addr = SocketAddr::from(([0, 0, 0, 0], 80));
    let tcp = TcpListener::bind(&addr).await.unwrap();

    axum::serve(tcp, router).await.unwrap();
}
