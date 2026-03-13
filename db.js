import mysql from "mysql2/promise";

// CrÃ©e un pool de connexions
const pool = mysql.createPool({
  host: "127.0.0.1",
  user: "root",
  password: "Magan_Serveur_DB",
  database: "magan_db",
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
});

export default pool;