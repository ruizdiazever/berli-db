use tokio_postgres::NoTls;

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let database_url = "postgresql://postgres:berliberli@localhost:5433/berli";

    // Order is mandatory
    let sql_files = vec![
        "./sql/001_init.sql",
        "./sql/002_index.sql",
        "./sql/003_functions.sql",
        "./sql/004_triggers.sql",
        "./sql/005_user.sql",
        "./sql/006_products.sql",
    ];

    // DB connection
    let (client, connection) = tokio_postgres::connect(&database_url, NoTls)
        .await
        .map_err(|e| {
            eprintln!("Error connecting to the database: {}", e);
            e
        })?;

    // Spawn a thread to manage the connection
    tokio::spawn(async move {
        if let Err(e) = connection.await {
            eprintln!("Connection error: {}", e);
        }
    });

    // Iteration and execution
    for sql_file in sql_files {
        let sql_content = std::fs::read_to_string(sql_file).map_err(|e| {
            eprintln!("Error reading SQL file {}: {}", sql_file, e);
            e
        })?;

        if let Err(e) = client.batch_execute(&sql_content).await {
            eprintln!("Error executing SQL file {}: {}", sql_file, e);
            return Err(e.into());
        }
    }

    println!("All SQL files executed successfully.");
    Ok(())
}
