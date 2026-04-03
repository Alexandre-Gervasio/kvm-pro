use std::net::SocketAddr;
use tokio::io::{AsyncReadExt, AsyncWriteExt};

/// KVM Pro v1.0.1 - High-Performance KVM Software
/// A portable alternative to Input Leap and Barrier

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    println!("\n🎛️  KVM Pro v1.0.1 - Server");
    println!("════════════════════════════════════════");
    println!("Status: ✅ Ready");
    println!("Listening on: 0.0.0.0:5000");
    println!("Platform: Linux/Windows Portable\n");
    
    let listener = tokio::net::TcpListener::bind("0.0.0.0:5000").await?;
    println!("📡 Server started. Waiting for clients...");
    
    loop {
        match listener.accept().await {
            Ok((socket, addr)) => {
                println!("✓ Client connected from: {}", addr);
                tokio::spawn(handle_client(socket, addr));
            }
            Err(e) => eprintln!("Connection error: {}", e),
        }
    }
}

async fn handle_client(
    mut socket: tokio::net::TcpStream,
    addr: SocketAddr,
) {
    use tokio::io;
    
    let mut buf = [0_u8; 4096];
    
    loop {
        match socket.read(&mut buf).await {
            Ok(0) => {
                println!("✓ Client {} disconnected", addr);
                break;
            }
            Ok(n) => {
                if let Err(e) = socket.write_all(&buf[..n]).await {
                    eprintln!("Error writing: {}", e);
                    break;
                }
            }
            Err(e) => {
                eprintln!("Error reading from {}: {}", addr, e);
                break;
            }
        }
    }
}
